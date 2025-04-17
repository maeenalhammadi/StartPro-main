import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:start_pro/core/lib/logger.dart';
import 'package:start_pro/core/providers/graphql_provider.dart';
import 'package:start_pro/core/types/types.dart';
import 'package:start_pro/features/home/graphql/get_businesses.dart';
import 'package:start_pro/features/home/graphql/get_models.dart';
import 'package:start_pro/features/home/models/business.dart';
import 'package:start_pro/features/home/models/model.dart';

final searchRepositoryProvider = Provider<ISearchRepository>(
  (ref) => SearchRepository(ref.watch(graphqlProvider)),
);

abstract class ISearchRepository {
  FutureEither<List<BusinessModel>> getBusinesses({
    String? slug,
    String locale = 'en',
    String? search,
  });
  FutureEither<List<Model>> getModels({String locale = 'en'});
}

class SearchRepository implements ISearchRepository {
  final GraphQLClient _client;

  SearchRepository(this._client);

  @override
  FutureEither<List<BusinessModel>> getBusinesses({
    String? slug,
    String locale = 'en',
    String? search,
  }) async {
    try {
      final result = await _client.query(
        QueryOptions(
          document: gql(getBusinessesQuery),
          variables: {
            'locale': locale,
            'filters': {
              ...(slug != null
                  ? {
                    "model": {
                      "slug": {"eq": slug},
                    },
                  }
                  : {}),
              "title": {"containsi": search?.toLowerCase().trim()},
            },
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      final businesses =
          (result.data?['businesses'] as List)
              .map((business) => BusinessModel.fromJson(business))
              .toList();
      return right(businesses);
    } catch (e) {
      logger.e(e);
      return left(Failure('Error fetching businesses', e.toString()));
    }
  }

  @override
  FutureEither<List<Model>> getModels({String locale = 'en'}) async {
    try {
      final result = await _client.query(
        QueryOptions(
          document: gql(getModelsQuery),
          variables: {'locale': locale},
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      final models =
          (result.data?['models'] as List)
              .map((model) => Model.fromMap(model))
              .toList();
      return right(models);
    } catch (e) {
      logger.e(e);
      return left(Failure('Error fetching models', e.toString()));
    }
  }
}

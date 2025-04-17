import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:start_pro/core/constants/env.dart';

final inMemoryStoreProvider = Provider<InMemoryStore>((ref) {
  // Only created once
  return InMemoryStore();
});

final graphqlProvider = Provider<GraphQLClient>((ref) {
  final AuthLink authLink = AuthLink(
    getToken: () {
      final token = Env.strapiToken;
      if (token.isEmpty) {
        return '';
      }
      return 'Bearer $token';
    },
  );

  final HttpLink httpLink = HttpLink(Env.graphqlUrl);
  final Link link = authLink.concat(httpLink);

  final store = ref.watch(inMemoryStoreProvider);

  return GraphQLClient(link: link, cache: GraphQLCache(store: store));
});

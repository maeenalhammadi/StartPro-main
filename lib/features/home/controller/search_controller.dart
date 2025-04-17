import 'package:flutter/cupertino.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:start_pro/features/home/controller/search_input_provider.dart';
import 'package:start_pro/features/home/controller/selected_tab_provider.dart';
import 'package:start_pro/features/home/models/business.dart';
import 'package:start_pro/features/home/models/model.dart';
import 'package:start_pro/features/home/repository/search_repository.dart';

final searchControllerProvider = Provider<SearchController>((ref) {
  return SearchController(
    searchRepository: ref.watch(searchRepositoryProvider),
  );
});

final searchControllerFutureProvider =
    FutureProvider.family<List<BusinessModel>, BuildContext>((
      ref,
      context,
    ) async {
      final controller = ref.watch(searchControllerProvider);
      final slug = ref.watch(selectedTabProvider);
      final search = ref.watch(searchInputProvider);

      return await controller.getBusinesses(context, slug, search);
    });

final modelsControllerFutureProvider =
    FutureProvider.family<List<Model>, BuildContext>((ref, context) async {
      final controller = ref.watch(searchControllerProvider);
      return await controller.getModels(context);
    });

abstract class ISearchController {
  Future<List<BusinessModel>> getBusinesses(
    BuildContext context,
    String? slug,
    String? search,
  );
  Future<List<Model>> getModels(BuildContext context);
}

class SearchState {
  final bool isLoading;
  final String? error;
  final List<BusinessModel> businesses;

  const SearchState({
    this.isLoading = false,
    this.error,
    this.businesses = const [],
  });

  SearchState copyWith({
    bool? isLoading,
    String? error,
    List<BusinessModel>? businesses,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      businesses: businesses ?? this.businesses,
    );
  }
}

class SearchController extends StateNotifier<SearchState>
    implements ISearchController {
  SearchController({required searchRepository})
    : _searchRepository = searchRepository,
      super(const SearchState());
  final ISearchRepository _searchRepository;

  @override
  Future<List<BusinessModel>> getBusinesses(
    BuildContext context,
    String? slug,
    String? search,
  ) async {
    final result = await _searchRepository.getBusinesses(
      slug: slug,
      locale: context.currentLocale?.languageCode ?? 'ar',
      search: search,
    );
    state = state.copyWith(isLoading: true);
    return result.fold(
      (failure) {
        state = state.copyWith(error: failure.message, isLoading: false);
        return [];
      },
      (businesses) {
        state = state.copyWith(businesses: businesses, isLoading: false);
        return businesses;
      },
    );
  }

  @override
  Future<List<Model>> getModels(BuildContext context) async {
    final result = await _searchRepository.getModels(
      locale: context.currentLocale?.languageCode ?? 'ar',
    );
    return result.fold((failure) => [], (models) => models);
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersControllerState {
  final String search;
  final String? selectedModelSlug;
  final int page;

  FiltersControllerState({
    required this.search,
    this.selectedModelSlug,
    this.page = 0,
  });

  FiltersControllerState copyWith({
    String? search,
    String? selectedModelSlug,
    int? page,
  }) {
    return FiltersControllerState(
      search: search ?? this.search,
      selectedModelSlug: selectedModelSlug ?? this.selectedModelSlug,
      page: page ?? this.page,
    );
  }
}

final filtersControllerProvider = StateProvider<FiltersControllerState>(
  (ref) => FiltersControllerState(search: '', selectedModelSlug: null),
);
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:start_pro/features/home/controller/selected_tab_provider.dart';
import 'package:start_pro/features/home/controller/search_controller.dart';
import 'package:start_pro/features/home/view/widgets/search/search_tab.dart';

class SearchTabs extends ConsumerWidget {
  const SearchTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedType = ref.watch(selectedTabProvider);
    final modelsAsync = ref.watch(modelsControllerFutureProvider(context));

    return modelsAsync.when(
      data:
          (models) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SearchTab(
                  context: context,
                  ref: ref,
                  slug: null,
                  label: Locales.string(context, 'all'),
                  isSelected: selectedType == null,
                ),
                SizedBox(width: 8.w),
                if (models.isNotEmpty)
                  ...models.map((model) {
                    return Row(
                      children: [
                        SearchTab(
                          context: context,
                          ref: ref,
                          slug: model.slug,
                          label: model.label,
                          isSelected: selectedType == model.slug,
                        ),
                        if (model != models.last) SizedBox(width: 8.w),
                      ],
                    );
                  }),
              ],
            ),
          ),
      loading:
          () => Row(
            children: [
              Skeletonizer(
                child: SearchTab(
                  context: context,
                  ref: ref,
                  slug: null,
                  label: Locales.string(context, 'all'),
                  isSelected: false,
                ),
              ),
              SizedBox(width: 8.w),
              Skeletonizer(
                child: SearchTab(
                  context: context,
                  ref: ref,
                  slug: null,
                  label: Locales.string(context, 'e-commerce'),
                  isSelected: false,
                ),
              ),
              SizedBox(width: 8.w),
              Skeletonizer(
                child: SearchTab(
                  context: context,
                  ref: ref,
                  slug: null,
                  label: Locales.string(context, 'shopping'),
                  isSelected: false,
                ),
              ),
            ],
          ),
      error: (error, stack) => Center(child: LocaleText('error_occurred')),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:start_pro/core/constants/animations.dart';
import 'package:start_pro/features/home/controller/search_controller.dart';
import 'package:start_pro/features/home/models/business.dart';
import 'package:start_pro/features/home/view/widgets/search/business_card.dart';

class SearchResults extends ConsumerWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final businessesAsync = ref.watch(searchControllerFutureProvider(context));

    return Expanded(
      child: businessesAsync.when(
        data: (businesses) {
          if (businesses.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(Animations.emptyFolder),
                LocaleText('no_businesses_found'),
              ],
            );
          }

          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: businesses.length,
            itemBuilder: (context, index) {
              return BusinessCard(business: businesses[index]);
            },
          );
        },
        loading:
            () => ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 10,
              itemBuilder:
                  (context, index) =>
                      BusinessCard(business: BusinessModel.empty()),
            ),
        error: (error, stack) => Center(child: LocaleText('error_occurred')),
      ),
    );
  }
}

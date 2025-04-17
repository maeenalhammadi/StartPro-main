import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:start_pro/core/providers/color_hunt_provider.dart';
import 'package:start_pro/features/home/view/screens/colors_screen.dart';

final colorsFutureProvider = FutureProvider<List<List<Color>>>((ref) async {
  final sort = ref.watch(sortState);
  final inspiration = ref.watch(inspirationState);
  final selectedStep = ref.watch(selectedStepState);

  final colorHunt = ref.read(colorHuntProvider);
  return await colorHunt.getColors(
    step: selectedStep,
    sort: sort,
    tags: inspiration,
  );
});

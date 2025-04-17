import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:start_pro/core/theme/palette.dart';
import 'package:start_pro/core/utils/debounce.dart';
import 'package:start_pro/core/widgets/form/select_input.dart';
import 'package:start_pro/features/home/controller/colors_controller.dart';
import 'package:start_pro/features/home/controller/selected_step_provider.dart';
import 'package:start_pro/features/home/data/inspiration_options.dart';
import 'package:start_pro/features/home/data/sort_options.dart';
import 'package:start_pro/features/home/view/widgets/home/colors_grid.dart';
import 'package:start_pro/features/home/view/widgets/shared/feature_header.dart';

final colorsListState = StateProvider<List<List<Color>>>((ref) => []);
final sortState = StateProvider<String>((ref) => 'random');
final inspirationState = StateProvider<String>((ref) => 'pastel');
final selectedStepState = StateProvider<int>((ref) => 0);

class ColorsScreen extends ConsumerStatefulWidget {
  static const route = '/colors';
  const ColorsScreen({super.key});

  @override
  ConsumerState<ColorsScreen> createState() => _ColorsScreenState();
}

class _ColorsScreenState extends ConsumerState<ColorsScreen> {
  final _sortDebounce = Debounce();
  final _inspirationDebounce = Debounce();

  @override
  void dispose() {
    _sortDebounce.dispose();
    _inspirationDebounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sort = ref.watch(sortState);
    final inspiration = ref.watch(inspirationState);
    final colors = ref.watch(colorsFutureProvider);
    final selectedStep = ref.watch(selectedStepProvider);
    final colorsList = ref.watch(colorsListState);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      floatingActionButton: FloatingActionButton(
        onPressed:
            selectedStep < colorsList.length - 1
                ? () {
                  ref.read(selectedStepProvider.notifier).state =
                      selectedStep + 1;

                  if (selectedStep == colorsList.length - 1) {
                    ref.read(selectedStepState.notifier).state += 1;
                  }
                }
                : null,
        child: const Icon(Icons.shuffle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FeatureHeader(
                  title: context.localeString('palette_generator'),
                  description: context.localeString(
                    'create_professional_palettes_with_ai',
                  ),
                  icon: Icons.palette,
                  color: AppColors.kAccentYellow,
                  tag: ColorsScreen.route,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: SelectInput<String>(
                        label: context.localeString('sort'),
                        value: sort,
                        options: sortOptions,
                        onChanged: (value) {
                          if (value != null) {
                            _sortDebounce(() {
                              ref.read(sortState.notifier).state = value;
                              ref.read(selectedStepProvider.notifier).state = 0;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SelectInput<String>(
                        label: context.localeString('inspiration'),
                        value: inspiration,
                        options: inspirationOptions,
                        onChanged: (value) {
                          if (value != null) {
                            _inspirationDebounce(() {
                              ref.read(inspirationState.notifier).state = value;
                              ref.read(selectedStepProvider.notifier).state = 0;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                colors.when(
                  data: (data) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (!mounted) return;
                      ref.read(colorsListState.notifier).state = data;
                    });
                    return ColorsGrid(
                      colors: data[selectedStep],
                      layoutIndex: selectedStep,
                    );
                  },
                  error: (error, stack) => Text(error.toString()),
                  loading:
                      () => Center(
                        child: ColorsGrid(
                          colors: [
                            ...List.generate(
                              4,
                              (index) => Colors.black.withAlpha(50),
                            ),
                          ],
                        ),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

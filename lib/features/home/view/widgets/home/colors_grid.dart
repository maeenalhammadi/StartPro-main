import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:start_pro/core/theme/palette.dart';

class ColorsGrid extends StatelessWidget {
  final List<Color> colors;
  final int layoutIndex;
  final double height;

  const ColorsGrid({
    super.key,
    required this.colors,
    this.layoutIndex = 0,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    assert(colors.length == 4, 'ColorsGrid requires exactly 4 colors');

    final patterns = [
      [
        _PositionedTile(
          left: 0.0,
          top: 0.0,
          width: 0.5,
          height: 0.5,
          colorIndex: 0,
        ),

        _PositionedTile(
          left: 0.5,
          top: 0.0,
          width: 0.5,
          height: 0.5,
          colorIndex: 1,
        ),

        _PositionedTile(
          left: 0.0,
          top: 0.5,
          width: 0.5,
          height: 0.5,
          colorIndex: 2,
        ),

        _PositionedTile(
          left: 0.5,
          top: 0.5,
          width: 0.5,
          height: 0.5,
          colorIndex: 3,
        ),
      ],

      [
        _PositionedTile(
          left: 0.0,
          top: 0.0,
          width: 1.0,
          height: 0.5,
          colorIndex: 0,
        ),
        _PositionedTile(
          left: 0.0,
          top: 0.5,
          width: 1 / 3,
          height: 0.5,
          colorIndex: 1,
        ),
        _PositionedTile(
          left: 1 / 3,
          top: 0.5,
          width: 1 / 3,
          height: 0.5,
          colorIndex: 2,
        ),
        _PositionedTile(
          left: 2 / 3,
          top: 0.5,
          width: 1 / 3,
          height: 0.5,
          colorIndex: 3,
        ),
      ],

      [
        _PositionedTile(
          left: 0.0,
          top: 0.0,
          width: 0.5,
          height: 1.0,
          colorIndex: 0,
        ),

        _PositionedTile(
          left: 0.5,
          top: 0.0,
          width: 0.5,
          height: 1 / 3,
          colorIndex: 1,
        ),
        _PositionedTile(
          left: 0.5,
          top: 1 / 3,
          width: 0.5,
          height: 1 / 3,
          colorIndex: 2,
        ),
        _PositionedTile(
          left: 0.5,
          top: 2 / 3,
          width: 0.5,
          height: 1 / 3,
          colorIndex: 3,
        ),
      ],

      [
        _PositionedTile(
          left: 0.00,
          top: 0.0,
          width: 0.25,
          height: 1.0,
          colorIndex: 0,
        ),
        _PositionedTile(
          left: 0.25,
          top: 0.0,
          width: 0.25,
          height: 1.0,
          colorIndex: 1,
        ),
        _PositionedTile(
          left: 0.50,
          top: 0.0,
          width: 0.25,
          height: 1.0,
          colorIndex: 2,
        ),
        _PositionedTile(
          left: 0.75,
          top: 0.0,
          width: 0.25,
          height: 1.0,
          colorIndex: 3,
        ),
      ],

      [
        _PositionedTile(
          left: 0.0,
          top: 0.00,
          width: 1.0,
          height: 0.25,
          colorIndex: 0,
        ),
        _PositionedTile(
          left: 0.0,
          top: 0.25,
          width: 1.0,
          height: 0.25,
          colorIndex: 1,
        ),
        _PositionedTile(
          left: 0.0,
          top: 0.50,
          width: 1.0,
          height: 0.25,
          colorIndex: 2,
        ),
        _PositionedTile(
          left: 0.0,
          top: 0.75,
          width: 1.0,
          height: 0.25,
          colorIndex: 3,
        ),
      ],
    ];

    final chosenPattern = patterns[layoutIndex % patterns.length];

    return AspectRatio(
      aspectRatio: 1.0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.biggest.shortestSide;
          final gap = size * 0.01;

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  for (final tile in chosenPattern)
                    Positioned(
                      left: tile.left * size + (tile.left > 0 ? gap : 0),
                      top: tile.top * size + (tile.top > 0 ? gap : 0),
                      width:
                          tile.width * size -
                          (tile.left > 0 ? gap : 0) -
                          (tile.left + tile.width < 1 ? gap : 0),
                      height:
                          tile.height * size -
                          (tile.top > 0 ? gap : 0) -
                          (tile.top + tile.height < 1 ? gap : 0),
                      child: _ColorTile(
                        color: colors[tile.colorIndex],
                        onTap: () {
                          final hex =
                              '#${colors[tile.colorIndex].value.toRadixString(16).substring(2)}';
                          Clipboard.setData(ClipboardData(text: hex));
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    const Icon(Icons.copy, color: Colors.white),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LocaleText(
                                          'copied_to_clipboard',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                        LocaleText(
                                          'access_the_color_code_from_your_clipboard',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                backgroundColor: AppColors.kPrimaryColor,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                duration: const Duration(seconds: 2),
                                margin: const EdgeInsets.only(
                                  top: 16,
                                  left: 16,
                                  right: 16,
                                ),
                                dismissDirection: DismissDirection.up,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PositionedTile {
  final double left;
  final double top;
  final double width;
  final double height;
  final int colorIndex;

  const _PositionedTile({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
    required this.colorIndex,
  });
}

class _ColorTile extends StatelessWidget {
  final Color color;
  final VoidCallback? onTap;

  const _ColorTile({required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:start_pro/core/theme/palette.dart';

class ColorInput extends StatelessWidget {
  const ColorInput({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.hint,
    this.error,
    this.enabled = true,
  });

  final String label;
  final Color? value;
  final ValueChanged<Color?> onChanged;
  final String? hint;
  final String? error;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Theme.of(context).platform == TargetPlatform.iOS) ...[
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 8),
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.kTextColor.withAlpha(700),
                  fontSize: 13,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.kSurfaceColorLight,
                borderRadius: BorderRadius.circular(12),
                border:
                    error != null
                        ? Border.all(color: AppColors.kErrorColor)
                        : null,
              ),
              child: CupertinoButton(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                onPressed: enabled ? () => _showColorPicker(context) : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (value != null) ...[
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: value,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: AppColors.kTextColor.withAlpha(200),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '#${value!.value.toRadixString(16).substring(2).toUpperCase()}',
                            style: const TextStyle(color: AppColors.kTextColor),
                          ),
                        ] else
                          Text(
                            hint ?? '',
                            style: TextStyle(
                              color: AppColors.kTextColor.withAlpha(500),
                            ),
                          ),
                      ],
                    ),
                    const Icon(
                      CupertinoIcons.chevron_down,
                      color: AppColors.kTextColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            InkWell(
              onTap: enabled ? () => _showColorPicker(context) : null,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(
                    color: AppColors.kTextColor.withAlpha(700),
                  ),
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: AppColors.kTextColor.withAlpha(500),
                  ),
                  filled: true,
                  fillColor: AppColors.kSurfaceColorLight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                  errorText: error,
                  errorStyle: const TextStyle(color: AppColors.kErrorColor),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.kErrorColor),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.kErrorColor),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (value != null) ...[
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: value,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: AppColors.kTextColor.withAlpha(200),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '#${value!.value.toRadixString(16).substring(2).toUpperCase()}',
                            style: const TextStyle(color: AppColors.kTextColor),
                          ),
                        ] else
                          Text(
                            hint ?? '',
                            style: TextStyle(
                              color: AppColors.kTextColor.withAlpha(500),
                            ),
                          ),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.kTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text(
                error!,
                style: const TextStyle(
                  color: AppColors.kErrorColor,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showColorPicker(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) => Container(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          child: FadeTransition(
            opacity: animation,
            child: AlertDialog(
              title: Text(
                label,
                style: const TextStyle(color: AppColors.kTextColor),
              ),
              backgroundColor: AppColors.kSurfaceColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: value ?? Colors.black,
                  onColorChanged: (Color color) {
                    onChanged(color);
                  },
                  pickerAreaHeightPercent: 0.8,
                  enableAlpha: false,
                  displayThumbColor: true,
                  showLabel: true,
                  paletteType: PaletteType.hsv,
                  pickerAreaBorderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: LocaleText(
                    'cancel',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.kTextColor.withAlpha(700),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: LocaleText(
                    'done',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.kTextColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

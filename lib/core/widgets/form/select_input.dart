import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:start_pro/core/theme/palette.dart';
import 'package:start_pro/core/types/option.dart';

class SelectInput<T> extends StatelessWidget {
  const SelectInput({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.hint,
    this.error,
    this.isLoading = false,
    this.enabled = true,
    this.validator,
  });

  final String label;
  final T? value;
  final List<Option<T>> options;
  final ValueChanged<T?> onChanged;
  final String? hint;
  final String? error;
  final bool isLoading;
  final bool enabled;
  final String? Function(T?)? validator;

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
                onPressed:
                    enabled && !isLoading
                        ? () => _showCupertinoPicker(context)
                        : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LocaleText(
                      options
                              .firstWhere(
                                (option) => option.value == value,
                                orElse: () => options.first,
                              )
                              .tag ??
                          hint ??
                          '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.kTextColor,
                      ),
                    ),
                    if (isLoading)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CupertinoActivityIndicator(
                          color: AppColors.kTextColor,
                        ),
                      )
                    else
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
            DropdownButtonFormField<T>(
              value: value,
              isExpanded: true,
              dropdownColor: AppColors.kSurfaceColor,
              style: const TextStyle(color: AppColors.kTextColor),
              icon:
                  isLoading
                      ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.kTextColor,
                          ),
                        ),
                      )
                      : const Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.kTextColor,
                      ),
              menuMaxHeight: 300,
              borderRadius: BorderRadius.circular(12),
              alignment: AlignmentDirectional.centerStart,
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
                  borderSide: const BorderSide(color: AppColors.kPrimaryColor),
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
              items:
                  options.map((Option<T> option) {
                    return DropdownMenuItem<T>(
                      value: option.value,
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: LocaleText(option.tag ?? ''),
                      ),
                    );
                  }).toList(),
              onChanged: enabled ? onChanged : null,
              validator: validator,
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

  void _showCupertinoPicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: const BoxDecoration(
            color: AppColors.kSurfaceColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: LocaleText(
                        'cancel',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.kTextColor,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    CupertinoButton(
                      child: LocaleText(
                        'done',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.kTextColor,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 32,
                    onSelectedItemChanged: (int index) {
                      onChanged(options[index].value);
                    },
                    children:
                        options.map((Option<T> option) {
                          return Center(
                            child: LocaleText(
                              option.tag ?? '',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.kTextColor, fontSize: 18),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

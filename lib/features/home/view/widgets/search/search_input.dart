import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:start_pro/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start_pro/features/home/controller/search_input_provider.dart';
import 'package:start_pro/core/utils/debounce.dart';

class SearchInput extends ConsumerStatefulWidget {
  const SearchInput({super.key});

  @override
  ConsumerState<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends ConsumerState<SearchInput> {
  final _controller = TextEditingController();
  final _debounce = Debounce(delay: const Duration(milliseconds: 500));
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _showClearButton = _controller.text.isNotEmpty;
      });

      _debounce(() {
        ref.read(searchInputProvider.notifier).state = _controller.text;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: _controller,
      hintText: Locales.string(context, 'search'),
      leading: Icon(
        Icons.search,
        color: AppColors.kTextTertiaryColor,
        size: 24.w,
      ),
      trailing: [
        if (_showClearButton)
          IconButton(
            icon: Icon(
              Icons.clear,
              color: AppColors.kTextTertiaryColor,
              size: 20.w,
            ),
            onPressed: () => _controller.clear(),
          ),
      ],
      backgroundColor: WidgetStateProperty.all(AppColors.kSurfaceColor),
      elevation: WidgetStateProperty.all(0),
      padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 12.w)),
      constraints: BoxConstraints(minHeight: 36.h, maxHeight: 36.h),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

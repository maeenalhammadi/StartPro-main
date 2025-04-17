import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:start_pro/core/theme/palette.dart';
import 'package:start_pro/core/types/option.dart';
import 'package:start_pro/core/widgets/form/color_input.dart';
import 'package:start_pro/core/widgets/form/select_input.dart';
import 'package:start_pro/core/widgets/loading_button.dart';
import 'package:start_pro/features/home/view/widgets/shared/feature_header.dart';

class LogoGeneratorScreen extends StatefulWidget {
  static const route = '/logo-generator';
  const LogoGeneratorScreen({super.key});

  @override
  State<LogoGeneratorScreen> createState() => _LogoGeneratorScreenState();
}

class _LogoGeneratorScreenState extends State<LogoGeneratorScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;
  String? _error;
  String? _generatedImageUrl;
  String? _selectedStyle;
  Color? _selectedColor = Colors.black;

  final List<Option<String>> _styles = [
    Option(value: 'minimalist', tag: 'Minimalist'),
    Option(value: 'modern', tag: 'Modern'),
    Option(value: 'classic', tag: 'Classic'),
    Option(value: 'playful', tag: 'Playful'),
    Option(value: 'elegant', tag: 'Elegant'),
    Option(value: 'bold', tag: 'Bold'),
  ];

  @override
  void dispose() {
    _businessNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FeatureHeader(
                  title: context.localeString('logo_generator'),
                  description: context.localeString(
                    'create_professional_logos_with_ai',
                  ),
                  icon: Icons.image,
                  color: AppColors.kErrorColor,
                  tag: LogoGeneratorScreen.route,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _businessNameController,
                  style: const TextStyle(color: AppColors.kTextColor),
                  decoration: InputDecoration(
                    labelText: context.localeString('business_name'),
                    labelStyle: TextStyle(
                      color: AppColors.kTextColor.withAlpha(700),
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
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.kErrorColor,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.kErrorColor,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.localeString(
                        'please_enter_your_business_name',
                      );
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: SelectInput<String>(
                        label: context.localeString('logo_style'),
                        value: _selectedStyle,
                        options: _styles,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedStyle = value;
                          });
                        },
                        hint: context.localeString('select_logo_style'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.localeString(
                              'please_select_logo_style',
                            );
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ColorInput(
                        label: context.localeString('logo_color'),
                        value: _selectedColor,
                        onChanged: (Color? value) {
                          setState(() {
                            _selectedColor = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  style: const TextStyle(color: AppColors.kTextColor),
                  decoration: InputDecoration(
                    labelText: context.localeString('additional_description'),
                    labelStyle: TextStyle(
                      color: AppColors.kTextColor.withAlpha(700),
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
                  ),
                ),
                const SizedBox(height: 24),
                LoadingButton(
                  text: context.localeString('generate_logo'),
                  onPressed: _generateLogo,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _generateLogo() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
      _generatedImageUrl = null;
    });

    // TODO: Implement logo generation logic
  }
}

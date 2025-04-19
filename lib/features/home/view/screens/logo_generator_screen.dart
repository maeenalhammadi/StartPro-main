import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:http/http.dart' as http;
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
                    filled: true,
                    fillColor: AppColors.kSurfaceColorLight,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
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
                        onChanged: (value) {
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
                        onChanged: (color) {
                          setState(() {
                            _selectedColor = color;
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
                    filled: true,
                    fillColor: AppColors.kSurfaceColorLight,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                LoadingButton(
                  text: context.localeString('generate_logo'),
                  onPressed: _generateLogo,
                  isLoading: _isLoading,
                ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (_generatedImageUrl != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Column(
                      children: [
                        Text(
                          context.localeString('generated_logo'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            _generatedImageUrl!,
                            height: 300,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _generateLogo() async {
    print("🚀 Generate logo button pressed");
    print("🔐 KEY CHECK: ${dotenv.env['OPENAI_LOGO_API_KEY']}");
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _error = null;
      _generatedImageUrl = null;
    });

    final apiKey = dotenv.env['OPENAI_LOGO_API_KEY'];
    print("🔐 API KEY: $apiKey");

    try {
      final hexColor =
          '#${_selectedColor?.value.toRadixString(16).substring(2).toUpperCase() ?? "#000000"}';

      final prompt =
          'Design a ${_selectedStyle ?? "modern"} logo for a business called "${_businessNameController.text.trim()}". '
          'Main color: $hexColor. '
          'Description: ${_descriptionController.text.trim()}';

      print("🔍 Prompt: $prompt");
      print("📤 Sending request to OpenAI...");

      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'dall-e-3',
          'prompt': prompt,
          'n': 1,
          'size': '1024x1024',
        }),
      );

      print('📦 STATUS CODE: ${response.statusCode}');
      print('📦 RESPONSE BODY: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final imageUrl = data['data'][0]['url'];
        setState(() {
          _generatedImageUrl = imageUrl;
        });
      } else {
        final error = jsonDecode(response.body);
        setState(() {
          _error = error['error']['message'] ?? 'Something went wrong';
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

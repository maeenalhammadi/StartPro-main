import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    Option(value: 'Minimalist', tag: 'Minimalist'),
    Option(value: 'Modern', tag: 'Modern'),
    Option(value: 'Classic', tag: 'Classic'),
    Option(value: 'Playful', tag: 'Playful'),
    Option(value: 'Elegant', tag: 'Elegant'),
    Option(value: 'Bold', tag: 'Bold'),
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
                  description: context.localeString('create_professional_logos_with_ai'),
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
                    labelStyle: TextStyle(color: AppColors.kTextColor.withAlpha(700)),
                    filled: true,
                    fillColor: AppColors.kSurfaceColorLight,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.localeString('please_enter_your_business_name');
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
                        onChanged: (val) => setState(() => _selectedStyle = val),
                        hint: context.localeString('select_logo_style'),
                        validator: (value) => (value == null || value.isEmpty)
                            ? context.localeString('please_select_logo_style')
                            : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ColorInput(
                        label: context.localeString('logo_color'),
                        value: _selectedColor,
                        onChanged: (val) => setState(() => _selectedColor = val),
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
                    labelStyle: TextStyle(color: AppColors.kTextColor.withAlpha(700)),
                    filled: true,
                    fillColor: AppColors.kSurfaceColorLight,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 24),
                LoadingButton(
                  text: context.localeString('generate_logo'),
                  onPressed: _generateLogo,
                  isLoading: _isLoading,
                ),
                if (_generatedImageUrl != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(_generatedImageUrl!),
                    ),
                  ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      _error!,
                      style: const TextStyle(color: AppColors.kErrorColor),
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
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _error = null;
      _generatedImageUrl = null;
    });

    final businessName = _businessNameController.text.trim();
    final description = _descriptionController.text.trim();
    final style = _selectedStyle ?? '';
    final colorHex = '#${_selectedColor?.value.toRadixString(16).substring(2) ?? '000000'}';
    final apiKey = dotenv.env['OPENAI_API_KEY'];

    final prompt = StringBuffer();
    prompt.write('Design a $style logo for a business named "$businessName". ');
    prompt.write('The logo should primarily use the color $colorHex. ');
    if (description.isNotEmpty) {
      prompt.write('Description: $description');
    }

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "dall-e-3",
          "prompt": prompt.toString(),
          "n": 1,
          "size": "1024x1024",
          "quality": "standard",
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final imageUrl = data['data'][0]['url'];

        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance.collection('logo_generator').add({
            'userId': user.uid,
            'email': user.email,
            'businessName': businessName,
            'style': style,
            'color': colorHex,
            'description': description,
            'imageUrl': imageUrl,
            'timestamp': FieldValue.serverTimestamp(),
          });
        }

        setState(() {
          _generatedImageUrl = imageUrl;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to generate logo. Try again.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'An error occurred: $e';
        _isLoading = false;
      });
    }
  }
}

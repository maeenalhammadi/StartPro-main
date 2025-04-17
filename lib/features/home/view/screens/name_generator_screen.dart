import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http show post;
import 'package:start_pro/core/theme/palette.dart';

class NameGeneratorScreen extends StatefulWidget {
  static const route = '/name-generator';

  const NameGeneratorScreen({super.key});

  @override
  State<NameGeneratorScreen> createState() => _NameGeneratorScreenState();
}

class _NameGeneratorScreenState extends State<NameGeneratorScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController productController = TextEditingController();
  final TextEditingController keywordsController = TextEditingController();

  String? selectedLanguage;
  String? selectedStyle;
  String? result;

  final List<String> languages = ['Arabic', 'English', 'Mixed'];
  final List<String> styles = ['Short & Catchy', 'Formal & Elegant'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.kSurfaceColor,
        elevation: 0,
        title: const Text("Name Generator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildField(
                "What product or service does the business offer?",
                productController,
              ),
              _buildDropdown(
                "Preferred Language",
                languages,
                selectedLanguage,
                (val) {
                  setState(() => selectedLanguage = val);
                },
              ),
              _buildDropdown("Desired Style", styles, selectedStyle, (val) {
                setState(() => selectedStyle = val);
              }),
              _buildField(
                "Any keywords or concepts to include?",
                keywordsController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _generateNames,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kSurfaceColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Generate Names",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (result != null) ...[
                const SizedBox(height: 24),
                Text(result!, style: const TextStyle(color: Colors.white)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.kSurfaceColor,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) return 'Required';
          return null;
        },
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    String? selectedValue,
    void Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        dropdownColor: AppColors.kSurfaceColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.kSurfaceColor,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
        items:
            items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white),
        validator: (value) => value == null ? 'Required' : null,
      ),
    );
  }

  Future<void> _generateNames() async {
    if (!_formKey.currentState!.validate()) return;

    final prompt = """
Suggest 5 creative business names for the following:
Product/Service: ${productController.text}
Preferred Language: $selectedLanguage
Desired Style: $selectedStyle
Include these keywords: ${keywordsController.text}

List the names in bullet points.
""";

    setState(() {
      result = "Generating names...";
    });

    final apiKey = dotenv.env['OPENAI_API_KEY'];
    print(dotenv.env['OPENAI_API_KEY']); // Should print the key
    if (apiKey == null || apiKey.isEmpty) {
      setState(() {
        result = "API Key not found. Please check your .env file.";
      });
      return;
    }
    final uri = Uri.parse("https://api.openai.com/v1/chat/completions");

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "system",
            "content": "You are a helpful branding assistant.",
          },
          {"role": "user", "content": prompt},
        ],
        "temperature": 0.8,
        "max_tokens": 150,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final content = json['choices'][0]['message']['content'];
      setState(() {
        result = content;
      });
    } else {
      setState(() {
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        result = "Failed to generate names. Please try again.";
      });
    }
  }
}

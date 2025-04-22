import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LabeledInputWithTooltip extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? tooltip;
  final TextInputType keyboardType;

  const LabeledInputWithTooltip({
    super.key,
    required this.controller,
    required this.label,
    this.tooltip,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (tooltip != null) ...[
                const SizedBox(width: 6),
                Tooltip(
                  message: tooltip!,
                  child: const Icon(Icons.info_outline, color: Colors.grey, size: 18),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(color: Colors.white),
            inputFormatters: keyboardType == TextInputType.number
                ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))]
                : [],
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF1E1E2C),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'Required';
              if (keyboardType == TextInputType.number &&
                  double.tryParse(value.trim()) == null) {
                return 'Enter numbers only';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

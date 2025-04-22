import 'package:flutter/material.dart';

class LabeledDropdownWithTooltip extends StatelessWidget {
  final String label;
  final String? tooltip;
  final List<String> items;
  final String? selectedValue;
  final void Function(String?) onChanged;

  const LabeledDropdownWithTooltip({
    super.key,
    required this.label,
    this.tooltip,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
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
                  child: Icon(Icons.info_outline, color: Colors.grey[400], size: 18),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: selectedValue,
            dropdownColor: const Color(0xFF1E1E2C),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF1E1E2C),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            items: items.map((e) {
              return DropdownMenuItem<String>(
                value: e,
                child: Text(
                  e,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select $label';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

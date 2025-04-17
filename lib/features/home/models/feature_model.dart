import 'package:flutter/material.dart';

class FeatureItem {
  final String label;
  final IconData icon;
  final String description;
  final VoidCallback? onTap;
  final String? path;

  const FeatureItem({
    required this.label,
    required this.icon,
    required this.description,
    this.onTap,
    this.path,
  });
}


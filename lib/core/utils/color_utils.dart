import 'package:flutter/material.dart';

class ColorPalette {
  final List<Color> colors;
  final int likes;
  final String date;

  ColorPalette({required this.colors, required this.likes, required this.date});

  factory ColorPalette.fromJson(Map<String, dynamic> json) {
    final String code = json['code'] as String;
    final List<Color> colors = _parseColorCode(code);

    return ColorPalette(
      colors: colors,
      likes: int.parse(json['likes'] as String),
      date: json['date'] as String,
    );
  }

  static List<Color> _parseColorCode(String code) {
    final List<Color> colors = [];

    // Split the code into 6-character chunks
    for (int i = 0; i < code.length; i += 6) {
      if (i + 6 <= code.length) {
        final String hex = code.substring(i, i + 6);
        colors.add(Color(int.parse('0xFF$hex')));
      }
    }

    return colors;
  }
}

List<ColorPalette> parseColorPalettes(List<dynamic> jsonList) {
  return jsonList.map((json) => ColorPalette.fromJson(json)).toList();
}

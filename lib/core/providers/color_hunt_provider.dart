import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/painting.dart';

class ColorHunt {
  static const String apiUrl = 'https://colorhunt.co/php/feed.php';
  final client = Dio(BaseOptions(baseUrl: apiUrl));

  Future<List<List<Color>>> getColors({
    required int step,
    required String sort,
    required String tags,
  }) async {
    try {
      final response = await client.post(
        '',
        data: FormData.fromMap({
          'step': step,
          'sort': 'new',
          'tags': tags,
          'timeframe': 365,
        }),
      );

      print(step);

      if (response.data == null) {
        throw Exception('No data received from the API');
      }

      final data = response.data;
      if (data is! String) {
        throw Exception(
          'Invalid response format: expected String, got ${data.runtimeType}',
        );
      }

      final List<dynamic> parsedData = jsonDecode(data);

      return parsedData.map((item) {
        if (item is! Map<String, dynamic>) {
          throw Exception(
            'Invalid item format: expected Map, got ${item.runtimeType}',
          );
        }

        final code = item['code'];
        if (code is! String) {
          throw Exception(
            'Invalid code format: expected String, got ${code.runtimeType}',
          );
        }

        return List.generate(
          code.length ~/ 6,
          (index) => Color(
            int.parse('0xFF${code.substring(index * 6, (index + 1) * 6)}'),
          ),
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch colors: $e');
    }
  }
}

final colorHuntProvider = Provider((ref) => ColorHunt());

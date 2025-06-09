import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:project/constants.dart';

class GemeniService {
  final String apiKey = secretkey;

  Future<Map<String, dynamic>?> sendImageToGemini(File image, String prompt) async {
    final dio = Dio();
    final bytes = await image.readAsBytes();
    final base64Image = base64Encode(bytes);

    final requestBody = {
      "contents": [
        {
          "parts": [
            {
              "inline_data": {
                "mime_type": "image/jpeg",
                "data": base64Image,
              },
            },
            {
              "text": prompt,
            },
          ],
        },
      ],
    };

    try {
      final response = await dio.post(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro:generateContent?key=$apiKey',
        options: Options(headers: {"Content-Type": "application/json"}),
        data: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final result = response.data;
      final text = result['candidates']?[0]?['content']?['parts']?[0]?['text'];
log('👁️‍🗨️ Gemini Response: $text');

try {
  final cleanedText = text
      ?.replaceAll('```json', '')
      .replaceAll('```', '')
      .trim();

  final decoded = jsonDecode(cleanedText!);
  if (decoded is Map<String, dynamic>) {
    return decoded;
  }
} catch (e) {
  log('🚨 Exception while parsing JSON: $e');
}

      } else {
        log('🚨 Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e) {
      log('🚨 Error: $e');
    }
}
}

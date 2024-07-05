// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class OtpService {
  final String baseUrl = 'https://node-otp-service.onrender.com';

  Future<void> requestOtp(String recipient) async {
    final url = Uri.parse('$baseUrl/otp/request');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'recipient': recipient}),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to request OTP');
      }
    } catch (err) {
      print('[OTP Service]: There was an error requesting an OTP');
      print(err);
      throw Exception(err);
    }
  }

  Future<void> verifyOtp(String recipient, String code) async {
    final url = Uri.parse('$baseUrl/otp/verify');
    final body = jsonEncode({'recipient': recipient, 'code': code});

    try {
      print("Request URL: $url");
      print("Request Body: $body");

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode != 200) {
        throw Exception('Failed to verify OTP');
      }
    } catch (err) {
      print('[OTP Service]: There was an error verifying the OTP');
      print(err);
      throw Exception(err);
    }
  }
}

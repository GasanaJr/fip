import 'dart:convert';
import 'package:http/http.dart' as http;

class OtpService {
  final String baseUrl =
      'https://maico-shared-messaging.onrender.com'; // Replace with your Hermes base URL

  Future<void> requestOtp(String recipient) async {
    final url = Uri.parse('$baseUrl/otp/request');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'source': 'iwacu_remit',
          'recipient': recipient,
        }),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to request OTP');
      }
    } catch (err) {
      print('[HERMES]: There was an error requesting an OTP');
      throw Exception(err);
    }
  }

  Future<void> verifyOtp(String recipient, String code) async {
    final url = Uri.parse('$baseUrl/otp/verify');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'source': 'iwacu_remit',
          'recipient': recipient,
          'code': code,
        }),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to verify OTP');
      }
    } catch (err) {
      print('[HERMES]: There was an error verifying the OTP');
      print(err);
      throw Exception(err);
    }
  }
}

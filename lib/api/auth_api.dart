import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthApi {
  final String apiUrl = dotenv.env['API_URL'].toString();

   Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$apiUrl/api/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        String token = jsonResponse['token'];
        await _saveToken(token);

        return {'status': true, 'token': jsonResponse['token']};
      } else {
        return {
          'status': false,
          'message': 'Login failed',
        };
      }
    } catch (e) {
      return {
        'status': false,
        'message': 'Error: $e',
      };
    }
  }

  Future<bool> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    final url = Uri.parse('$apiUrl/api/auth/me');
    final token = await getToken();
    if (token == null) {
      return {
        'status': false,
        'message': 'Token not found. Please log in again.',
      };
    }

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return {
          'status': true,
          'data': jsonResponse['data'],
        };
      } else {
        return {
          'status': false,
          'message': 'Failed to fetch user profile',
        };
      }
    } catch (e) {
      return {
        'status': false,
        'message': 'Error: $e',
      };
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Fungsi untuk menyimpan token ke SharedPreferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
}
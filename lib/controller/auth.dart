import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/model/user.dart';

class AuthService {
  final String baseUrl = "http://your-api-url/api/v1/users";

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final user = User.fromJson(data['user']);
      final token = data['token'];
      return {'user': user, 'token': token};
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>> register(String username, String email, String password, String role) async {
    final response = await http.post(
      Uri.parse('$baseUrl/registration'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'role': role,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final user = User.fromJson(data['user']);
      final token = data['token'];
      return {'user': user, 'token': token};
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<void> logout() async {
    final response = await http.get(Uri.parse('$baseUrl/logout'));
    if (response.statusCode != 200) {
      throw Exception('Failed to logout');
    }
  }
}

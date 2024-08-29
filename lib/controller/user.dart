import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';  // Needed for JSON encoding and decoding

class UserController {
  final String baseUrl = 'http://192.168.100.105:4000/api/v1/users';

  Future<void> register(String username, String email, String password, String role) async {
    final url = Uri.parse('$baseUrl/new');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
          'role': role,
        }),
      );

      if (response.statusCode == 201) {
        print(jsonDecode(response.body)['message']);
      } else {
        print('Failed to register user: ${response.body}');
      }
    } catch (e) {
      print('Error registering user: $e');
    }
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        print(jsonDecode(response.body)['message']);
      } else {
        print('Failed to log in: ${response.body}');
      }
    } catch (e) {
      print('Error logging in: $e');
    }
  }

  Future<void> logout() async {
    final url = Uri.parse('$baseUrl/logout');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print(jsonDecode(response.body)['message']);
      } else {
        print('Failed to log out: ${response.body}');
      }
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  Future<void> getMyProfile() async {
    final url = Uri.parse('$baseUrl/profile');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print(jsonDecode(response.body)['user']);
      } else {
        print('Failed to get profile: ${response.body}');
      }
    } catch (e) {
      print('Error getting profile: $e');
    }
  }
}

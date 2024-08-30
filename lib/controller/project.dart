import 'dart:convert';
import 'package:frontend/model/project.dart';
import 'package:http/http.dart' as http;

class ProjectService {
  final String baseUrl = "http://your-api-url/api/v1/users/project";

  // Fetch all projects
  Future<List<Project>> fetchProjects(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['projects'] as List;
      return data.map((project) => Project.fromJson(project)).toList();
    }
    return [];
  }

  // Create a new project
  Future<Project?> createProject(String title, String description, List<String> assignedEmployeeIds, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': title,
        'description': description,
        'assignedEmployees': assignedEmployeeIds,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['project'];
      return Project.fromJson(data);
    }
    return null;
  }

  // Edit an existing project
  Future<Project?> editProject(String id, String newTitle, String newDescription, List<String> newAssignedEmployeeIds, String token) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': newTitle,
        'description': newDescription,
        'assignedEmployees': newAssignedEmployeeIds,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['project'];
      return Project.fromJson(data);
    }
    return null;
  }

  // Delete a project
  Future<bool> deleteProject(String id, String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    return response.statusCode == 204;
  }
}

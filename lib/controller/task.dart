import 'dart:convert';
import 'package:frontend/model/task.dart';
import 'package:http/http.dart' as http;


class TaskService {
  final String baseUrl = "http://your-api-url/api/v1/task";

  // Fetch all tasks for a specific project
  Future<List<Task>> fetchTasks(String projectId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl?projectId=$projectId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['tasks'] as List;
      return data.map((task) => Task.fromJson(task)).toList();
    }
    return [];
  }

  // Add a new task
  Future<Task?> addTask(String title, String description, String projectId, String assignedEmployeeId, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': title,
        'description': description,
        'projectId': projectId,
        'assignedEmployeeId': assignedEmployeeId,
      }),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['task'];
      return Task.fromJson(data);
    }
    return null;
  }

  // Update task status
  Future<Task?> updateTaskStatus(String taskId, String status, String token) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/$taskId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'status': status}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['task'];
      return Task.fromJson(data);
    }
    return null;
  }

  // Delete a task
  Future<bool> deleteTask(String taskId, String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$taskId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return response.statusCode == 200;
  }
}

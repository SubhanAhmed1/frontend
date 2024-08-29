import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class TaskController {
  final Dio _dio = Dio();

  Future<void> createTask(String title, String description, List<String> assignedEmployees, String projectId, String dueDate) async {
    try {
      final response = await _dio.post(
        'http://your-backend-url.com/api/tasks',
        data: {
          'title': title,
          'description': description,
          'assignedEmployees': assignedEmployees,
          'project': projectId,
          'dueDate': dueDate,
        },
      );
      print(response.data['message']);
    } catch (e) {
      print('Error creating task: $e');
    }
  }

  Future<void> getTasks() async {
    try {
      final response = await _dio.get('http://your-backend-url.com/api/tasks');
      print(response.data['tasks']);
    } catch (e) {
      print('Error getting tasks: $e');
    }
  }

  Future<void> getTaskByProjectId(String projectId) async {
    try {
      final response = await _dio.get('http://your-backend-url.com/api/tasks/project/$projectId');
      print(response.data['tasks']);
    } catch (e) {
      print('Error getting tasks by project: $e');
    }
  }

  Future<void> updateTaskStatus(String taskId) async {
    try {
      final response = await _dio.put('http://your-backend-url.com/api/tasks/$taskId/status');
      print(response.data['message']);
    } catch (e) {
      print('Error updating task status: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      final response = await _dio.delete('http://your-backend-url.com/api/tasks/$taskId');
      print(response.data['message']);
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
}

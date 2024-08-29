import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ProjectController {
  final Dio _dio = Dio();

  Future<void> createProject(String title, String description, List<String> assignedEmployees) async {
    try {
      final response = await _dio.post(
        'http://your-backend-url.com/api/projects',
        data: {
          'title': title,
          'description': description,
          'assignedEmployees': assignedEmployees,
        },
      );
      print(response.data['message']);
    } catch (e) {
      print('Error creating project: $e');
    }
  }

  Future<void> getProjects() async {
    try {
      final response = await _dio.get('http://your-backend-url.com/api/projects');
      print(response.data['projects']);
    } catch (e) {
      print('Error getting projects: $e');
    }
  }

  Future<void> getProjectById(String projectId) async {
    try {
      final response = await _dio.get('http://your-backend-url.com/api/projects/$projectId');
      print(response.data['project']);
    } catch (e) {
      print('Error getting project: $e');
    }
  }

  Future<void> updateProject(String projectId, Map<String, dynamic> updateData) async {
    try {
      final response = await _dio.put(
        'http://your-backend-url.com/api/projects/$projectId',
        data: updateData,
      );
      print(response.data['message']);
    } catch (e) {
      print('Error updating project: $e');
    }
  }

  Future<void> deleteProject(String projectId) async {
    try {
      final response = await _dio.delete('http://your-backend-url.com/api/projects/$projectId');
      print(response.data['message']);
    } catch (e) {
      print('Error deleting project: $e');
    }
  }
}

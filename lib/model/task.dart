

import 'package:frontend/model/project.dart';
import 'package:frontend/model/user.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final String status;
  final User assignedEmployee;
  final Project project;

  Task({required this.id, required this.title, required this.description, required this.status, required this.assignedEmployee, required this.project});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      assignedEmployee: User.fromJson(json['assignedEmployee']),
      project: Project.fromJson(json['project']),
    );
  }
}

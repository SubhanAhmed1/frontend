

import 'package:frontend/model/user.dart';

class Project {
  final String id;
  final String title;
  final String description;
  final User createdBy;
  final List<User> assignedEmployees;

  Project({required this.id, required this.title, required this.description, required this.createdBy, required this.assignedEmployees});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      createdBy: User.fromJson(json['createdBy']),
      assignedEmployees: (json['assignedEmployees'] as List).map((i) => User.fromJson(i)).toList(),
    );
  }
}

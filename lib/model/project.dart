import 'package:frontend/model/task.dart';

class Project {
  final String id;
  final String title;
  final String description;
  final String ownerId; // Admin ID
  final List<String> memberIds; // List of User IDs
  final List<Task> tasks;

  Project({required this.id, required this.title, required this.description, required this.ownerId, required this.memberIds, required this.tasks});
}

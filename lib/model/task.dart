class Task {
  final String id;
  final String title;
  final String description;
  final String projectId;
  final String status; // 'pending' or 'completed'
  final List<String> assignedTo;

  Task({required this.id, required this.title, required this.description, required this.projectId, required this.status, required this.assignedTo});
}

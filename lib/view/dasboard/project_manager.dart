import 'package:flutter/material.dart';
import 'package:frontend/model/project.dart';

class AdminDashboard extends StatelessWidget {
  final List<Project> projects; // Injected from the controller

  AdminDashboard({required this.projects});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(projects[index].title),
            subtitle: Text('Tasks: ${projects[index].tasks.length}'),
            onTap: () {
              // Navigate to ProjectDetailView
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to CreateProjectView
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

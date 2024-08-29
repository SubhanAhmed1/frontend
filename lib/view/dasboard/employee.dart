import 'package:flutter/material.dart';
import 'package:frontend/model/task.dart';

class EmployeeDashboard extends StatelessWidget {
  final List<Task> tasks; // Injected from the controller

  EmployeeDashboard({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
      appBar: AppBar(title: Text('Employee Dashboard')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].title),
            subtitle: Text('Status: ${tasks[index].status}'),
            onTap: () {
              // Navigate to TaskDetailView
            },
          );
        },
      ),
    );
  }
}

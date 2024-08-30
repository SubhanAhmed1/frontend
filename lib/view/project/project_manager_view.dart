import 'package:flutter/material.dart';
import 'package:frontend/controller/project.dart';
import 'package:frontend/provider/auth_provider.dart';
import 'package:frontend/utils/projectModal.dart';
import 'package:provider/provider.dart';
import 'package:frontend/model/project.dart';


class ProjectManagerScreen extends StatefulWidget {
  @override
  _ProjectManagerScreenState createState() => _ProjectManagerScreenState();
}

class _ProjectManagerScreenState extends State<ProjectManagerScreen> {
  late Future<List<Project>> _projects;

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  void _fetchProjects() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = authProvider.token;
    _projects = ProjectService().fetchProjects(token!);
  }

  void _showProjectModal({Project? project}) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = authProvider.token;
    final result = await showModalBottomSheet<Project>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ProjectModal(project: project),
    );

    if (result != null) {
      // If a new project was added or an existing project was updated, refresh the project list
      setState(() {
        _fetchProjects();
      });
    }
  }

  void _deleteProject(String projectId) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = authProvider.token;
    final success = await ProjectService().deleteProject(projectId, token!);

    if (success) {
      // Refresh the project list after deletion
      setState(() {
        _fetchProjects();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Manager'),
      ),
      body: FutureBuilder<List<Project>>(
        future: _projects,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching projects'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No projects available'));
          } else {
            final projects = snapshot.data!;
            return ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return ListTile(
                  title: Text(project.title),
                  subtitle: Text(project.description ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showProjectModal(project: project),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteProject(project.id),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showProjectModal(),
        child: Icon(Icons.add),
      ),
    );
  }
}

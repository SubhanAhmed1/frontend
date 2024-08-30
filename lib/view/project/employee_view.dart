import 'package:flutter/material.dart';
import 'package:frontend/controller/project.dart';
import 'package:frontend/view/auth/login.dart';
import 'package:provider/provider.dart';
import 'package:frontend/provider/auth_provider.dart';
import 'package:frontend/model/project.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  late ProjectService _projectService;
  List<Project> _projects = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _projectService = ProjectService();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final projects = await _projectService.fetchProjects(authProvider.token!);
      setState(() {
        _projects = projects;
        _isLoading = false;
      });
    } catch (error) {
      // Handle the error by showing a snackbar or error widget
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load projects')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _projects.isEmpty
              ? Center(child: Text('No projects assigned'))
              : ListView.builder(
                  itemCount: _projects.length,
                  itemBuilder: (context, index) {
                    final project = _projects[index];
                    return ListTile(
                      title: Text(project.title),
                      subtitle: Text('Description: ${project.description}'),
                      onTap: () {
                        // Navigate to a screen showing project details and tasks
                      },
                    );
                  },
                ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}

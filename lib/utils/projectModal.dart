import 'package:flutter/material.dart';
import 'package:frontend/controller/project.dart';
import 'package:frontend/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:frontend/model/project.dart';

class ProjectModal extends StatefulWidget {
  final Project? project;

  ProjectModal({this.project});

  @override
  _ProjectModalState createState() => _ProjectModalState();
}

class _ProjectModalState extends State<ProjectModal> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  List<String> _assignedEmployeeIds = [];

  @override
  void initState() {
    super.initState();
    if (widget.project != null) {
      _title = widget.project!.title;
      _description = widget.project!.description ?? '';
      _assignedEmployeeIds = widget.project!.assignedEmployees.map((e) => e.id).toList();
    } else {
      _title = '';
      _description = '';
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;
      if (widget.project == null) {
        await ProjectService().createProject(_title, _description, _assignedEmployeeIds, token!);
      } else {
        await ProjectService().editProject(widget.project!.id, _title, _description, _assignedEmployeeIds, token!);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  _description = value!;
                },
              ),
              // Add code for selecting employees (from all users) and updating _assignedEmployeeIds
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.project == null ? 'Create Project' : 'Update Project'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

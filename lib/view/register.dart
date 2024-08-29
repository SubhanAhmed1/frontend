import 'package:flutter/material.dart';
import 'package:frontend/controller/user.dart';
 // Import the UserController

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserController _UserController = UserController();  // Instantiate the UserController

  String _selectedRole = 'employee';  // Default role

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,  // Hide password text
              ),
              DropdownButton<String>(
                value: _selectedRole,
                items: <String>['project_manager', 'employee']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRole = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),  // Add some spacing
              ElevatedButton(
                onPressed: () async {
                  String name = _nameController.text;
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  
                  // Call the UserController's register method
                  await _UserController.register(name, email, password, _selectedRole);
                  
                  // Clear the text fields after submission
                  _nameController.clear();
                  _emailController.clear();
                  _passwordController.clear();
                  
                  // Optionally, you could also reset the role to default
                  setState(() {
                    _selectedRole = 'employee';
                  });
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

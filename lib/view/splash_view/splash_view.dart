

import 'package:flutter/material.dart';
import 'package:frontend/provider/auth_provider.dart';
import 'package:frontend/view/auth/login.dart';
import 'package:frontend/view/project/project_manager_view.dart';
import 'package:frontend/view/project/employee_view.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkAuthentication(context);
  }

  Future<void> _checkAuthentication(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Simulate a delay for splash screen
    await Future.delayed(Duration(seconds: 2));

    if (authProvider.isAuthenticated) {
      if (authProvider.user!.role == 'project_manager') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProjectManagerScreen()),
        );
      } else if (authProvider.user!.role == 'employee') {
       Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => EmployeeScreen()),
);
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }
}

class EmployeeScreen {
}

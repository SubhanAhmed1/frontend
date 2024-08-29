import 'package:flutter/material.dart';
import 'package:frontend/view/dasboard/employee.dart';
import 'package:frontend/view/dasboard/project_manager.dart';
import 'package:frontend/view/login.dart';
import 'package:frontend/view/register.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUpView());
      case '/signin':
        return MaterialPageRoute(builder: (_) => SignInView());
      case '/admin/dashboard':
        return MaterialPageRoute(builder: (_) => AdminDashboard(projects: const []));
      case '/employee/dashboard':
        return MaterialPageRoute(builder: (_) => EmployeeDashboard(tasks: const []));
      default:
        return MaterialPageRoute(builder: (_) => SignInView());
    }
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/view/splash_view/splash_view.dart';
import 'package:provider/provider.dart';
import 'package:frontend/controller/auth.dart';
import 'package:frontend/provider/auth_provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(AuthService()),
      child: MaterialApp(
        title: 'Project Management App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

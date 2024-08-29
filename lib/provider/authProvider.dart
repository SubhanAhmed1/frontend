import 'package:flutter/material.dart';
import 'package:frontend/model/user.dart';

class AuthProvider extends ChangeNotifier {
  User? currentUser;

  void signIn(User user) {
    currentUser = user;
    notifyListeners();
  }

  void signOut() {
    currentUser = null;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:phmss_patient_app/models/user.dart';

class UserProvider extends ChangeNotifier {
  User? user;

  void setUser(User user) {
    user = user;
    notifyListeners();
  }

  // Method to update user from JSON object
  void updateUserFromJson(Map<String, dynamic> json) {
    user = User.fromJson(json);
    notifyListeners();
  }
}

// import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getString('token') != null;
    notifyListeners();
  }

// Login
Future<bool> login(String email, String password) async {

  if (email.trim() == "test@test.com" &&
      password.trim() == "1234") {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', "dummy_token");

    _isAuthenticated = true;
    notifyListeners();

    print("LOGIN SUCCESS");
    return true;
  }

  print("LOGIN FAILED");
  return false;
}

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _isAuthenticated = false;
    notifyListeners();
  }
}
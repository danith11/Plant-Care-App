import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  // This is a mockAPI . So thats why I hardcoded this here. 
  final String _apiKey = "free_user_3CpqMm0sJC0FG2kjp3I7Ac6RzXv";

  Future<void> checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getString('token') != null;
    notifyListeners();
  }

  // Login
  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        headers: {"Content-Type": "application/json", "x-api-key": _apiKey},
        body: json.encode({"email": email.trim(), "password": password.trim()}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);

        _isAuthenticated = true;
        notifyListeners();
        print("LOGIN SUCCESS");
        return true;
      }

      print("LOGIN FAILED: ${response.statusCode} - ${response.body}");
      return false;
    } catch (e) {
      print("LOGIN ERROR: $e");
      return false;
    }
  }

// Signup
  Future<void> signup(String name, String email, String password) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', 'simulated_signup_token_123');
      
      _isAuthenticated = true;
      
    } catch (e) {
      _errorMessage = 'Signup failed. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _isAuthenticated = false;
    notifyListeners();
  }
}
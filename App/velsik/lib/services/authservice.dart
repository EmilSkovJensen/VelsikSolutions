import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final SharedPreferences _prefs;

  AuthService(this._prefs);

  Future<void> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // If server returns 200 OK, save authentication state
      await _prefs.setBool('isLoggedIn', true);
    } else {
      // Handle authentication error
      throw Exception('Failed to sign in');
    }
  }

  Future<void> signOut() async {
    // Perform sign out logic here
    // Clear authentication state
    await _prefs.setBool('isLoggedIn', false);
  }

  Future<bool> isLoggedIn() async {
    // Check if user is logged in
    return _prefs.getBool('isLoggedIn') ?? false;
  }
}

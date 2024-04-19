import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velsik/models/user.dart';
import 'package:velsik/services/userservice.dart';

class AuthService {
  final SharedPreferences _prefs;

  AuthService(this._prefs);
  UserService userService = UserService();

  Future<void> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String token = responseData['token'];

      // Send another HTTP request to decode the token and retrieve the user ID
      final decodeResponse = await http.get(
        Uri.parse('http://10.0.2.2:8000/decode_token?token=$token'),
      );

      if (decodeResponse.statusCode == 200) {
        final Map<String, dynamic> decodeData = jsonDecode(decodeResponse.body);
        final int userId = decodeData['user_id'];

        // Store the token and user ID securely
        await _prefs.setString('token', token);
        await _prefs.setInt('userId', userId);
        
        final User user = await userService.getUserById();
        await _prefs.setInt('companyId', user.companyId);
        
        

        // Save authentication state
        await _prefs.setBool('isLoggedIn', true);
      } else {
        // Handle error when decoding token
        throw Exception('Failed to decode token');
      }
    } else {
      // Handle authentication error
      throw Exception('Failed to sign in');
    }
  }

  Future<void> signOut() async {
    // Perform sign out logic here
    // Clear authentication state
    await _prefs.setBool('isLoggedIn', false);

    // Clear token and user ID
    await _prefs.remove('token');
    await _prefs.remove('userId');
  }

  Future<bool> isLoggedIn() async {
    // Check if user is logged in
    return _prefs.getBool('isLoggedIn') ?? false;
  }
}

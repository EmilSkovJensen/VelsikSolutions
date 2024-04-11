import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'services/authservice.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _welcomeMessage = 'Welcome';

  @override
  void initState() {
    super.initState();
    _getUserById();
  }

  Future<void> _getUserById() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');
    if (userId != null) {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/user/getbyid?user_id=$userId'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String firstName = responseData['user']['firstname'];
        setState(() {
          _welcomeMessage = 'Welcome, $firstName';
        });
      } else {
        setState(() {
          _welcomeMessage = 'Failed to retrieve user';
        });
      }
    } else {
      setState(() {
        _welcomeMessage = 'User ID not found';
      });
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        Center(
          child: Text(_welcomeMessage),
        ),
        Positioned(
          bottom: 16, // Adjust the value to change the button's distance from the bottom
          left: 0,
          right: 0,
          child: Center(
            child: ElevatedButton(
              onPressed: () async {
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                final AuthService authService = AuthService(prefs);
                await authService.signOut();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Logout'),
            ),
          ),
        ),
      ],
    ),
  );
}

}

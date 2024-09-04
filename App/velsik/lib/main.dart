import 'package:flutter/material.dart';
import 'login.dart';
import 'home.dart';
import 'services/authservice.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black, // This is where you set your primary color
          primary: Colors.black, // This sets the primary color used throughout the app
        ),
        useMaterial3: true, // Optional: If you want to use Material Design 3
      ),
      home: Directionality(
        textDirection: TextDirection.ltr, // Adjust this according to your app's text direction
        child: FutureBuilder<bool>(
          future: _checkLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              final bool isLoggedIn = snapshot.data ?? false;
              if (isLoggedIn) {
                return const HomePage();
              } else {
                return const LoginPage();
              }
            }
          },
        ),
      ),
    );
  }

  Future<bool> _checkLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final AuthService authService = AuthService(prefs);
    return authService.isLoggedIn();
  }
}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/authservice.dart';
import 'login.dart';

class ApvPage extends StatefulWidget {
  const ApvPage({super.key, required int userid});

  @override
  _ApvPageState createState() => _ApvPageState();
}

class _ApvPageState extends State<ApvPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 0, 
            right: 0, 
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: GestureDetector(
                  onTap: () async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    final AuthService authService = AuthService(prefs);
                    await authService.signOut();

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: Image.asset('assets/apv.png'),
                ),
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 0, 
            right: 0, 
            child: Padding(
              padding: const EdgeInsets.all(18.0), 
              child: Center(
                child: GestureDetector(
                  onTap: () async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    final AuthService authService = AuthService(prefs);
                    await authService.signOut();

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: Image.asset('assets/handlingsplan.png'),
                ),
              ),
            ),
          ),
          Positioned(
            top: 300, 
            left: 0, 
            right: 0, 
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: GestureDetector(
                  onTap: () async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    final AuthService authService = AuthService(prefs);
                    await authService.signOut();

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: Image.asset('assets/moeder-og-referater.png'),
                ),
              ),
            ),
          ),
          Positioned(
            top: 400, 
            left: 0, 
            right: 0, 
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: GestureDetector(
                  onTap: () async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    final AuthService authService = AuthService(prefs);
                    await authService.signOut();

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: Image.asset('assets/medarbejdere.png'),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16, 
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




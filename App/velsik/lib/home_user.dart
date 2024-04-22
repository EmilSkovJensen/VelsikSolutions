import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/authservice.dart';
import 'login.dart';
import 'services/userservice.dart';

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({super.key});

  @override
  _HomeUserPageState createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  final UserService userService = UserService();

  
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
        // If the user is not a super user, display an empty page
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
            ),
            body: Stack( children:[
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
            ])
          ); 
      
    
  }
}



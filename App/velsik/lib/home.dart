import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/authservice.dart';
import 'login.dart';
import 'services/userservice.dart';
import 'apv.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserService userService = UserService();

  //User related
  int _userId = 0;
  bool _isSuperUser = false;
  //

  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    userService.getUserById().then((user) {
      if (user != null && user['user']['user_role'] == 'superuser') {
        setState(() {
          _userId = user['user']['user_id'];
          _isSuperUser = true;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if(_isLoading == true) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      if (!_isSuperUser) {
        // If the user is not an admin, display an empty page
        return Scaffold(body: Container()); 
      }

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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ApvPage(userid: _userId,)),
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
}



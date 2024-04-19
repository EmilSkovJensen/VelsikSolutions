import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/authservice.dart';
import 'login.dart';
import 'services/userservice.dart';
import 'apv/apv_page.dart';

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
      if (user != null && user.userRole == 'superuser') {
        setState(() {
          _userId = user.userId;
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

      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true, 
        title: Text("Unikabyg A/S"), 
        ),
        body: Stack(
          children: [
            Positioned(
              top: 20,
              left: 0, 
              right: 0, 
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ApvPage(userid: _userId)),
                      );
                    },
                    child: Image.asset('assets/apv.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 120,
              left: 0, 
              right: 0, 
              child: Padding(
                padding: const EdgeInsets.all(18.0), 
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ApvPage(userid: _userId)),
                      );
                    },
                    child: Image.asset('assets/handlingsplan.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 220, 
              left: 0, 
              right: 0, 
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ApvPage(userid: _userId)),
                      );
                    },
                    child: Image.asset('assets/moeder-og-referater.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 320, 
              left: 0, 
              right: 0, 
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ApvPage(userid: _userId)),
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



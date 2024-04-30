import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/authservice.dart';
import 'login.dart';
import 'services/userservice.dart';
import 'apv/apv_page.dart';
import 'home_user.dart';

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
      if (user.userRole == 'superuser') {
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
        return const HomeUserPage();
      }

      return Scaffold(
        backgroundColor: const Color(0xFF2596BE),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF2596BE),
          automaticallyImplyLeading: false,
          centerTitle: true,
          toolbarHeight: 100, 
        title: const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Center(child: Text("Unikabyg A/S", style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.w900))),
        ), 
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
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
              top: 100,
              left: 0, 
              right: 0, 
              child: Padding(
                padding: const EdgeInsets.all(18.0), 
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Center(child: Text('Fejl meddelse')),
                              content: Text('Denne funktion er ikke implementeret endnu', textAlign: TextAlign.center),
                            );
                          },
                      );
                    },
                    child: Image.asset('assets/handlingsplan.png'),
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
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Center(child: Text('Fejl meddelse')),
                              content: Text('Denne funktion er ikke implementeret endnu', textAlign: TextAlign.center),
                            );
                          },
                      );
                    },
                    child: Image.asset('assets/moeder-og-referater.png'),
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
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Center(child: Text('Fejl meddelse')),
                              content: Text('Denne funktion er ikke implementeret endnu', textAlign: TextAlign.center),
                            );
                          },
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
                    child: Image.asset('assets/log-ud.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}



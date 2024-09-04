import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/authservice.dart';
import 'login.dart';
import 'services/userservice.dart';
import 'apv/apv_page.dart';
import 'home_user.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          
          toolbarHeight: 100, 
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              const Text("Menu", style: TextStyle(fontSize: 50, color: Colors.black, fontWeight: FontWeight.w900)),
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.46),
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
                    child: Icon(
                      MdiIcons.logout,
                      color: Colors.black,
                      size: 50.0,
                    ),
                  )
                ),
              ),
            ],
          ),
        ), 
        ),
        body: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04, right: MediaQuery.of(context).size.width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MaterialButton(
                minWidth: double.infinity,
                height: MediaQuery.of(context).size.height * 0.1,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ApvPage(userid: _userId)),
                  );
                },
                color: const Color(0xFFF2F2F7),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),  
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.005, right: MediaQuery.of(context).size.height * 0.02),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255,76,118,236),
                          borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                        ),
                        child: Center(
                          child: Icon(
                            MdiIcons.tools,  // Using `note-plus-outline` icon
                            color: Colors.white,
                            size: 30.0,  // Adjust the icon size as needed
                          ),
                        ),
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "APV-Værktøj", 
                          style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Colors.black,  
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "Dit foretrukne apv værktøj", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          
                          fontSize: 12,
                          color: Colors.grey,  
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ), 
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              MaterialButton(
                minWidth: double.infinity,
                height: MediaQuery.of(context).size.height * 0.1,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ApvPage(userid: _userId)),
                  );
                },
                color: const Color(0xFFF2F2F7),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),  
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.005, right: MediaQuery.of(context).size.height * 0.02),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255,118,129,150),
                          borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.note_add_outlined,  // Using `note-plus-outline` icon
                            color: Colors.white,
                            size: 30.0,  // Adjust the icon size as needed
                          ),
                        ),
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Handlingsplan", 
                          style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Colors.black,  
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "Lav en handlingsplan", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          
                          fontSize: 12,
                          color: Colors.grey,  
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ), 
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              MaterialButton(
                minWidth: double.infinity,
                height: MediaQuery.of(context).size.height * 0.1,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ApvPage(userid: _userId)),
                  );
                },
                color: const Color(0xFFF2F2F7),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),  
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.005, right: MediaQuery.of(context).size.height * 0.02),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255,211,81,138),
                          borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                        ),
                        child: Center(
                          child: Icon(
                            MdiIcons.laptopAccount,  // Using `note-plus-outline` icon
                            color: Colors.white,
                            size: 30.0,  // Adjust the icon size as needed
                          ),
                        ),
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Møder og Referater", 
                          style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Colors.black,  
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "Planlæg møder", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          
                          fontSize: 12,
                          color: Colors.grey,  
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ), 
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              MaterialButton(
                minWidth: double.infinity,
                height: MediaQuery.of(context).size.height * 0.1,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ApvPage(userid: _userId)),
                  );
                },
                color: const Color(0xFFF2F2F7),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),  
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.005, right: MediaQuery.of(context).size.height * 0.02),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255,155,92,161),
                          borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.people,  // Using `note-plus-outline` icon
                            color: Colors.white,
                            size: 30.0,  // Adjust the icon size as needed
                          ),
                        ),
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Medarbejdere", 
                          style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Colors.black,  
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "Hold styr på hvem der skal involveres", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          
                          fontSize: 12,
                          color: Colors.grey,  
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ), 
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            ],
          ),
        ),
      );
    }
  }
}



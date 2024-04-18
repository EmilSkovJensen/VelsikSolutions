import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/authservice.dart';
import '../login.dart';
import 'create-apv/choose_category.dart';

class ApvPage extends StatefulWidget {
  const ApvPage({super.key, required int userid});

  @override
  _ApvPageState createState() => _ApvPageState();
}

class _ApvPageState extends State<ApvPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios,
          size: 20,
          color: Colors.black,),
          


        ),
        centerTitle: true, 
        title: const Text("APV Værktøj"), 
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
                      MaterialPageRoute(builder: (context) => const ApvIndustryPage()),
                    );
                  },
                  child: Image.asset('assets/opret-apv.png'),
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
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: Image.asset('assets/nuvaerende-apv.png'),
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
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: Image.asset('assets/tidligere-apv.png'),
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




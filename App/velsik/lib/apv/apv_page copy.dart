import 'package:flutter/material.dart';
import 'package:velsik/apv/current_apv/user_statuses.dart';
import 'package:velsik/apv/previous_apv/previous_apv_page.dart';
import 'create_apv/choose_category.dart';

class ApvPage extends StatefulWidget {
  const ApvPage({super.key, required int userid});

  @override
  _ApvPageState createState() => _ApvPageState();
}

class _ApvPageState extends State<ApvPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2596BE),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF2596BE),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "APV-Værktøj",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
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
                        MaterialPageRoute(builder: (context) => const UserStatusesPage()),
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
                      MaterialPageRoute(builder: (context) => const PreviousApvPage()),
                    );
                  },
                  child: Image.asset('assets/tidligere-apv.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




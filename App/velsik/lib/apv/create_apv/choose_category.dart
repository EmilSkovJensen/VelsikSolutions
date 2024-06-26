import 'package:flutter/material.dart';
import 'package:velsik/apv/create_apv/choose_type.dart';
import '/login.dart';

class ApvIndustryPage extends StatefulWidget {
  const ApvIndustryPage({super.key});

  @override
  _ApvIndustryPageState createState() => _ApvIndustryPageState();
}

class _ApvIndustryPageState extends State<ApvIndustryPage> {

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
          icon: const Icon(Icons.arrow_back_ios,
          size: 20,
          color: Colors.white,),
          


        ),
        centerTitle: true, 
        title: const Text("Vælg kategori", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w900)), 
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
                      MaterialPageRoute(builder: (context) => const ApvTypePage(category: "Bygge og anlæg")),
                    );
                  },
                  child: Image.asset('assets/byggeoganlaeg.png'),
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
                  child: Image.asset('assets/butikogengros.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




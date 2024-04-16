import 'package:flutter/material.dart';
import 'package:velsik/apv-tool/create-apv/choose-type.dart';
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
        title: Text("Vælg branche"), 
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
                      MaterialPageRoute(builder: (context) => const ApvTypePage(industry: "Bygge og anlæg")),
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




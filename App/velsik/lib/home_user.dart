import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velsik/apv/response_page.dart';
import 'package:velsik/models/apv.dart';
import 'package:velsik/services/apvservice.dart';
import 'services/authservice.dart';
import 'login.dart';
import 'package:intl/intl.dart'; 

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({super.key});

  @override
  _HomeUserPageState createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  final ApvService apvService = ApvService();
  List<Apv>? apvs = [];
  
  @override
  void initState() {
    super.initState();

    apvService.getApvsByUserId().then((allApvs) => {
      setState(() {
          if(allApvs != null){
            apvs = allApvs;
          } 
      })
    });
  }
  
 @override
  Widget build(BuildContext context) {
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
      body: apvs != null && apvs!.isEmpty
          ? Stack(
            children: [
              Positioned(
              top: 0,
              bottom: 0, 
              left: 0, 
              right: 0, 
              child: Image.asset('assets/checkmark.png', scale: 0.25),
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
          ) 
          : Stack(
            children: [
                ListView.builder(
                itemCount: apvs!.length,
                itemBuilder: (context, index) {
                  final apv = apvs![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResponsePage(apv: apv),
                      ),
                    );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Card(
                        child: ListTile(
                          title: Text('APV Nummer: ${apv.apvId}'),
                          subtitle: Text('Start dato: ${DateFormat('dd-MM-yyyy').format(apv.startDate!).toString()}, Slut dato: ${DateFormat('dd-MM-yyyy').format(apv.endDate!).toString()}'),
                        ),
                      ),
                    ),
                  );
                },
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



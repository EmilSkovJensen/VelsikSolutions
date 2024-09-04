import 'package:flutter/material.dart';
import 'services/authservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Velsik Solutions",
                  style: GoogleFonts.montserrat(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic
                    ,)
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                    child: Text("Login to your account",
                      style: TextStyle(
                      fontSize: 15,
                      color:Colors.grey[700])
                    ,),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                      child: TextField(
                        controller: emailController,
                        obscureText: false,
                        style: const TextStyle(decoration: TextDecoration.none),
                        decoration: const InputDecoration(
                          hintText: "Email", // Add a hint text similar to the placeholder
                          hintStyle: TextStyle(color: Colors.grey), // Set the hint text color
                          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20), // Adjust padding
                          filled: true, // Enable background color
                          fillColor: Color(0xFFF2F2F7), // Set background color similar to the image
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none, // Remove the border
                            borderRadius: BorderRadius.all(Radius.circular(30)), // Add rounded corners
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                      child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          style: const TextStyle(decoration: TextDecoration.none),
                          decoration: const InputDecoration(
                            hintText: "Password", // Add a hint text similar to the placeholder
                            hintStyle: TextStyle(color: Colors.grey), // Set the hint text color
                            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20), // Adjust padding
                            filled: true, // Enable background color
                            fillColor: Color(0xFFF2F2F7), // Set background color similar to the image
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none, // Remove the border
                              borderRadius: BorderRadius.all(Radius.circular(30)), // Add rounded corners
                            ),
                          ),
                      ),
                    ),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async {
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        final AuthService authService = AuthService(prefs);
                        await authService.signIn(emailController.text, passwordController.text);
                          
                        // Check if the user is logged in after sign-in
                        bool isLoggedIn = await authService.isLoggedIn();
                        if (isLoggedIn) {
                          // Navigate to the home page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                        }
                      },
                      color: const Color.fromARGB(255,76,119,236),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),  
                      ),
                      child: const Text(
                        "Login", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,  
                        ),
                      ), 
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account?"),
                          Text(" Sign up", style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,        
                          ),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

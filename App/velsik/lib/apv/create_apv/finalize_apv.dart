import 'package:flutter/material.dart';
import 'package:velsik/services/apvservice.dart';
import 'package:velsik/models/question.dart';
import 'package:velsik/models/user.dart';
import 'package:velsik/apv/create_apv/choose_receivers.dart';

class FinalizeApvPage extends StatefulWidget {
  final List<Question> questions;
  final List<User> selectedUsers; 

  const FinalizeApvPage({super.key, required this.questions, required this.selectedUsers});

  @override
  _FinalizeApvPageState createState() => _FinalizeApvPageState();
}


class _FinalizeApvPageState extends State<FinalizeApvPage> {
  final ApvService apvService = ApvService();
  List<Question> apvQuestions = [];
  

 @override
  void initState() {
    super.initState();
  }

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
        title: const Text("Vælg spørgsmål"), 
      ),
      body: const Text("Vælg spørgsmål"),  //CHANGE TO CHOOSE START AND END DATE.

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            //API CALL WITH APV OBJECT

            //CHECK IF CALL WAS STATUS 200, IF IT IS WE USE NAVIGATOR PUSH
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ApvReceiversPage(questions: apvQuestions)),
            );
          },
          child: const Text('Send'),
        ),
      ),
    );
  }
}
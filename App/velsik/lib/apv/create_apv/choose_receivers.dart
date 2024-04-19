import 'package:flutter/material.dart';
import 'package:velsik/models/question.dart';
import 'package:velsik/models/department.dart';
import 'package:velsik/services/apvservice.dart';
import 'package:velsik/apv/create_apv/choose_questions.dart';
import 'package:velsik/services/userservice.dart';


class ApvReceiversPage extends StatefulWidget {
  final List<Question> questions;

  const ApvReceiversPage({super.key, required this.questions});

  @override
  _ApvReceiversPageState createState() => _ApvReceiversPageState();
}


class _ApvReceiversPageState extends State<ApvReceiversPage> {
  final UserService userService = UserService();
  final ApvService apvService = ApvService();
  List<Department> departments = []; //departments
  String? selectedType; //List selected departments

 @override
  void initState() {
    super.initState();

    //Retrieve list of departments which has a list of users
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
        title: const Text("Vælg medarbejdere"), 
      ),
          body: Align(
            alignment: Alignment.center,
           child: ListView.builder(
        itemCount: departments.length,
        itemBuilder: (context, index) {
          final department = departments[index];
          return ListTile(
            leading: Radio<String>(
              value: department.departmentName,
              groupValue: selectedType,
              onChanged: (String? value) {
                setState(() {
                  selectedType = value;
                });
              },
            ),
            title: Text(department.departmentName),
            onTap: () {
              setState(() {
                selectedType = department.departmentName;
              });
            },
          );
        },
      ),
    ),
    bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: selectedType != null ? () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ApvQuestionPage(type: selectedType)),
            );
          } : null, // Disable the button if no type is selected
          child: const Text('Næste'),
        ),
      ),
    );
        
  }
}
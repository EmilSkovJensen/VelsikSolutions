import 'package:flutter/material.dart';
import 'package:velsik/models/question.dart';
import 'package:velsik/models/department.dart';
import 'package:velsik/models/user.dart';
import 'package:velsik/services/apvservice.dart';
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
  List<User> selectedUsers = []; //List selected departments

  @override
  void initState() {
    super.initState();
List<User> users = [
    User(
      1,
      1,
      1,
      'user1@example.com',
      'password1',
      'John',
      'Doe',
      '123456781',
      'Role',
    ),
    User(
      2,
      1,
      1,
      'user2@example.com',
      'password2',
      'Jane',
      'Smith',
      '123456782',
      'Role',
    ),
    // Add more users here up to 10
    User(
      10,
      1,
      2,
      'user10@example.com',
      'password10',
      'Alice',
      'Johnson',
      '123456789',
      'Role',
    ),
  ];
    
    departments = [
      Department(1, "Tømrer", users.where((user) => user.departmentId == 1).toList()),
      Department(2, "Kontor", users.where((user) => user.departmentId == 2).toList()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vælg modtagere'),
      ),
      body: ListView.builder(
        itemCount: departments.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(departments[index].departmentName),
            leading: Checkbox(
              value: departments[index].users.every((user) => selectedUsers.contains(user)),
              onChanged: (bool? value) {
                setState(() {
                  if (value ?? false) {
                    for(var i = 0; i < departments[index].users.length; i++){
                        selectedUsers.remove(departments[index].users[i]);
                        selectedUsers.add(departments[index].users[i]); 
                    }
                    
                  } else {
                    for(var i = 0; i < departments[index].users.length; i++){
                      selectedUsers.remove(departments[index].users[i]);
                    }
                  }
                });
              },
            ),
            children: departments[index].users.map((user) {
              return ListTile(
                title: Text("${user.firstname} ${user.lastname}"),
                leading: Checkbox(
                  value: selectedUsers.contains(user),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value ?? false) {
                        selectedUsers.add(user);
                      } else {
                        selectedUsers.remove(user);
                      }
                    });
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
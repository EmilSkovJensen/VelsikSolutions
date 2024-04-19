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
  List<Department> departments = []; 
  List<Department> tempDepartments = []; 
  List<User> selectedUsers = []; 

  @override
  void initState() {
    super.initState();
    
    userService.getDepartmentsAndUsersByCompanyId().then((fetchedDepartments) {
      if(fetchedDepartments != null){
        setState(() {
          for(Department department in fetchedDepartments){
            if(department.users.isNotEmpty){
              departments.add(department);
            }
          }
        });
      } 
    });
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
              return Padding(
          padding: const EdgeInsets.only(left: 16.0),
              child: ListTile(
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
              ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
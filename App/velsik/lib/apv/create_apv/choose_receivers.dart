import 'package:flutter/material.dart';
import 'package:velsik/apv/create_apv/finalize_apv.dart';
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
          "Vælg modtagere",
          style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w900),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: departments.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: Text(departments[index].departmentName, style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600)),
                leading: Checkbox(
                  fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.white;
                    }
                    return Colors.transparent; 
                  }),
                  checkColor: const Color(0xFF2596BE), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0), 
                  ),
                  side: const BorderSide(color: Colors.white),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.transparent), 
                  value: departments[index].users.every((user) => selectedUsers.contains(user)),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value ?? false) {
                        for (var i = 0; i < departments[index].users.length; i++) {
                          selectedUsers.remove(departments[index].users[i]);
                          selectedUsers.add(departments[index].users[i]);
                        }
                      } else {
                        for (var i = 0; i < departments[index].users.length; i++) {
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
                      title: Text("${user.firstname} ${user.lastname}", style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600)),
                      leading: Checkbox(
                        fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return Colors.white;
                          }
                          return Colors.transparent; 
                        }),
                        checkColor: const Color(0xFF2596BE), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0), 
                        ),
                        side: const BorderSide(color: Colors.white),
                        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
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
          Positioned(
            bottom: 16, 
            left: 0, 
            right: 0, 
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: GestureDetector(
                  onTap: selectedUsers.isNotEmpty ? () async {
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FinalizeApvPage(
                                    questions: widget.questions,
                                    selectedUsers: selectedUsers,
                                  )),
                    );
                  } : null,
                  child: Image.asset('assets/næste.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
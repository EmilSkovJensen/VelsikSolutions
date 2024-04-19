import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velsik/models/department.dart';

import '../models/user.dart';

class UserService {

  Future<User> getUserById() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');
    if (userId != null) {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/user/getbyid?user_id=$userId'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final fetchedUser = responseData['user'];
        User user = User(fetchedUser['user_id'], fetchedUser['company_id'], fetchedUser['department_id'], fetchedUser['email'], fetchedUser['password'], fetchedUser['firstname'], fetchedUser['lastname'], fetchedUser['phone_number'], fetchedUser['user_role']);

        return user;
      }else {
        throw Exception(); //Error handling
      }
    }else {
      throw Exception(); //Error handling
    }
  }

  Future<List<Department>?> getDepartmentsAndUsersByCompanyId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');
    final int? companyId = prefs.getInt('companyId');
   
    List<Department> departments = [];

    if (userId != null) {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/department/get_departments_and_users?company_id=$companyId'),
      );
      if (response.statusCode == 200) {
        final String responseBody = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> responseData = jsonDecode(responseBody);

        for (Map<String, dynamic> department in responseData['departments']) {
          List<User> users = [];
          for (Map<String, dynamic> user in department['users']) {
            users.add(User(
              user['user_id'],
              user['company_id'],
              user['department_id'],
              user['email'],
              user['password'],
              user['firstname'],
              user['lastname'],
              user['phone_number'],
              user['user_role'],
            ));
          }

          departments.add(Department(
            department['department_id'],
            department['department_name'],
            users,
          ));
        }

        return departments;
      }else {
        return null; //ERROR HANDLING
      }
    }else {
      return null; //ERROR HANDLING
    }
  }



}

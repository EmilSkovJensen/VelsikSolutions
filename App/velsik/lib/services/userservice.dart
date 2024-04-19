import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserService {

  Future<User?> getUserById() async {
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
        return null; //ERROR HANDLING
      }
    }else {
      return null; //ERROR HANDLING
    }
  }

  Future<Map<String, dynamic>?> getDepartmentsAndUsersByCompanyId(String companyId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');
    int? companyId;
    getUserById().then((user) {
      if (user != null) {
        companyId = user.companyId;
      } 
    });
  
    if (userId != null) {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000//department/get_departments_and_users?company_id$companyId'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['departments'];
      }else {
        return null; //ERROR HANDLING
      }
    }else {
      return null; //ERROR HANDLING
    }
  }



}

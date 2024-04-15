import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {

  Future<Map<String, dynamic>?> getUserById() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');
    if (userId != null) {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/user/getbyid?user_id=$userId'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      }else {
        return null; //ERROR HANDLING
      }
    }else {
      return null; //ERROR HANDLING
    }
  }




}

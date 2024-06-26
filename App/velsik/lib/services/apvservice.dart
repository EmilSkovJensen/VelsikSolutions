import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velsik/models/question.dart';
import 'package:velsik/models/apv.dart';
import 'package:velsik/models/response.dart';
import 'package:velsik/models/user_response_status.dart';


class ApvService {

  Future<List<Question>?> getTemplateQuestionsByTypeName(String? typeName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null) {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/apv/get_template_questions?apv_type=$typeName'),
        headers: {
          'Authorization': 'Bearer $token', // Include the token in the request headers
        },
      );
      if (response.statusCode == 200) {
        final String responseBody = utf8.decode(response.bodyBytes); // Decode response body using UTF-8 to be able to see Danish letters in application
        final Map<String, dynamic> responseData = jsonDecode(responseBody);
        final List<Question> questions = [];

        for(final obj in responseData['questions']){
          Question question = Question(obj[0], null, obj[1], obj[2], obj[3]);
          questions.add(question);
        }

        return questions;
      }else {
        return null; //ERROR HANDLING
      }
    }else {
      return null; //ERROR HANDLING
    }
  }

  Future<bool> insertApv(Apv apv) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final int? companyId = prefs.getInt('companyId');
    apv.companyId = companyId;
    if (token != null) {
      final Map<String, dynamic> apvJson = apv.toJson(); // Convert Apv object to JSON
      
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/apv/insert'),
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
          'Authorization': 'Bearer $token', // Include the token in the request headers
        },
        body: json.encode(apvJson), // Encode the Apv object as JSON and include it in the request body
      );
      if (response.statusCode == 200) {
        return true;
      }else {
        return false; //ERROR HANDLING
      }
    }else {
      return false; //ERROR HANDLING
    }
  }

  Future<List<String>?> getApvTypesByCategory(String category) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null) {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/apv/get_types?apv_category=$category'),
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
          'Authorization': 'Bearer $token', // Include the token in the request headers
        },
      );
      if (response.statusCode == 200) {
        final String responseBody = utf8.decode(response.bodyBytes); // Decode response body using UTF-8 to be able to see Danish letters in application
        final Map<String, dynamic> responseData = jsonDecode(responseBody);
        final List<String> types = [];

        for(final obj in responseData['types']){
          types.add(obj[0]);
        }

        return types;
      }else {
        return null; //ERROR HANDLING
      }
    }else {
      return null; //ERROR HANDLING
    }
  }

  Future<List<Question>?> getQuestionsByApvId(int apvId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null) {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/apv/get_questions?apv_id=$apvId'),
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
          'Authorization': 'Bearer $token', // Include the token in the request headers
        },
      );
      if (response.statusCode == 200) {
        final String responseBody = utf8.decode(response.bodyBytes); // Decode response body using UTF-8 to be able to see Danish letters in application
        final Map<String, dynamic> responseData = jsonDecode(responseBody);
        final List<Question> questions = [];

        for(final obj in responseData['questions']){
          questions.add(Question(obj[0], obj[1], null, obj[2], obj[3]));
        }

        return questions;
      }else {
        return null; //ERROR HANDLING
      }
    }else {
      return null; //ERROR HANDLING
    }
  }

  Future<List<Question>?> getQuestionStatsByApvId(int apvId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null) {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/apv/get_question_stats?apv_id=$apvId'),
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
          'Authorization': 'Bearer $token', // Include the token in the request headers
        },
      );
      if (response.statusCode == 200) {
        final String responseBody = utf8.decode(response.bodyBytes); // Decode response body using UTF-8 to be able to see Danish letters in application
        final Map<String, dynamic> responseData = jsonDecode(responseBody);
        final List<Question> questions = [];

        for(final obj in responseData['questions']){
          Question question = Question(obj[0], null, null, obj[1], obj[2]);
          question.totalAttendees = obj[3];
          question.yesCount = obj[4];
          question.noCount = obj[5];

          questions.add(question);
        }

        return questions;
      }else {
        return null; //ERROR HANDLING
      }
    }else {
      return null; //ERROR HANDLING
    }
  }


  Future<List<Apv>?> getApvsByUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final int? userId = prefs.getInt('userId');
    if (token != null) {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/apv/get_remaining_apvs?users_id=$userId'),
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
          'Authorization': 'Bearer $token', // Include the token in the request headers
        },
      );
      if (response.statusCode == 200) {
        final String responseBody = utf8.decode(response.bodyBytes); // Decode response body using UTF-8 to be able to see Danish letters in application
        final Map<String, dynamic> responseData = jsonDecode(responseBody);
        final List<Apv> apvs = [];

        for(final obj in responseData['apvs']){
          List<Question>? questions = await getQuestionsByApvId(obj['apv_id']);
          apvs.add(Apv(obj['apv_id'], obj['company_id'], DateTime.parse(obj['start_date']), DateTime.parse(obj['end_date']), questions, null));
        }

        return apvs;
      }else {
        return null; //ERROR HANDLING
      }
    }else {
      return null; //ERROR HANDLING
    }
  }

  Future<bool> insertResponses(List<Response> responses) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    
    List<Map<String, dynamic>> encodedResponses = [];
    for (Response response in responses){
      encodedResponses.add(response.toJson());
    }

    if (token != null) { 
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/apv/answer'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', 
        },
        body: json.encode({"data": encodedResponses}), 
      );
      if (response.statusCode == 200) {
        return true;
      }else {
        return false; //ERROR HANDLING
      }
    }else {
      return false; //ERROR HANDLING
    }
  }

  Future<List<UserResponseStatus>?> getCurrentApvUserStatuses() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final int? companyId = prefs.getInt('companyId');
    if (token != null) {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/apv/get_response_statuses?company_id=$companyId'),
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
          'Authorization': 'Bearer $token', // Include the token in the request headers
        },
      );
      if (response.statusCode == 200) {
        final String responseBody = utf8.decode(response.bodyBytes); // Decode response body using UTF-8 to be able to see Danish letters in application
        final Map<String, dynamic> responseData = jsonDecode(responseBody);
        final List<UserResponseStatus> statuses = [];

        for(final obj in responseData['statuses']){
          statuses.add(UserResponseStatus(obj['firstname'], obj['lastname'], obj['email'], obj['phone_number'], obj['status']));
        }

        return statuses;
      }else {
        return null; //ERROR HANDLING
      }
    }else {
      return null; //ERROR HANDLING
    }

  }

  Future<List<Apv>?> getPreviousApvsByCompanyId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final int? companyId = prefs.getInt('companyId');
    if (token != null) {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/apv/get_previous_apvs?company_id=$companyId'),
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
          'Authorization': 'Bearer $token', // Include the token in the request headers
        },
      );
      if (response.statusCode == 200) {
        final String responseBody = utf8.decode(response.bodyBytes); // Decode response body using UTF-8 to be able to see Danish letters in application
        final Map<String, dynamic> responseData = jsonDecode(responseBody);
        final List<Apv> apvs = [];

        for(final obj in responseData['previous_apvs']){
          List<Question>? questions = await getQuestionStatsByApvId(obj['apv_id']);
          apvs.add(Apv(obj['apv_id'], obj['company_id'], DateTime.parse(obj['start_date']), DateTime.parse(obj['end_date']), questions, null));
        }

        return apvs;
      }else {
        return null; //ERROR HANDLING
      }
    }else {
      return null; //ERROR HANDLING
    }
  }

  Future<List<String>?> getCommentsByQuestionId(int? questionId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null) {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/question/get_comments_by_question_id?question_id=$questionId'),
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
          'Authorization': 'Bearer $token', // Include the token in the request headers
        },
      );
      if (response.statusCode == 200) {
        final String responseBody = utf8.decode(response.bodyBytes); // Decode response body using UTF-8 to be able to see Danish letters in application
        final Map<String, dynamic> responseData = jsonDecode(responseBody);
        final List<String> comments = [];

        for(final obj in responseData['comments']){
          comments.add(obj);
        }

        return comments;
      }else {
        return null; //ERROR HANDLING
      }
    }else {
      return null; //ERROR HANDLING
    }
  }







}

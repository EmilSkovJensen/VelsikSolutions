import 'question.dart';
import 'user.dart';

class Apv {
  int? apvId;
  int? companyId;
  DateTime? startDate;
  DateTime? endDate;
  List<Question>? questions;
  List<User>? users;

  Apv(
    this.apvId,
    this.companyId,
    this.startDate,
    this.endDate,
    this.questions,
    this.users
  );
  
  // Convert Apv object to a JSON-encodable map
  Map<String, dynamic> toJson() {
    return {
      'apv_id': apvId,
      'company_id': companyId,
      'start_date': startDate?.toIso8601String(), // Convert DateTime to ISO 8601 format
      'end_date': endDate?.toIso8601String(), // Convert DateTime to ISO 8601 format
      'questions': questions?.map((question) => question.toJson()).toList() ?? [], // Convert list of Question objects to JSON
      'users': users?.map((user) => user.toJson()).toList() ?? [], // Convert list of User objects to JSON
    };
  }

}
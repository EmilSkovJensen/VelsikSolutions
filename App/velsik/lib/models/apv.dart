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
  
  Map<String, dynamic> toJson() {
    return {
      'apv_id': apvId,
      'company_id': companyId,
      'start_date': startDate,
      'end_date': endDate,
      'questions': questions,
      'users': users
    };
  }

}
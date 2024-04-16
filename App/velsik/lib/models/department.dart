import 'user.dart';

class Department {
  int? departmentId;
  String? departmentName;
  List<User>? users;

  Department(
    this.departmentId,
    this.departmentName,
    this.users,
  );
  
  Map<String, dynamic> toJson() {
    return {
      'department_id': departmentId,
      'departmentName': departmentName,
      'users': users
    };
  }

}
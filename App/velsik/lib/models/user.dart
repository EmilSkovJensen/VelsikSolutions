class User {
  int userId;
  int companyId;
  int? departmentId;
  String email;
  String password;
  String firstname;
  String lastname;
  String phoneNumber;
  String userRole;

  User(
    this.userId,
    this.companyId,
    this.departmentId,
    this.email,
    this.password,
    this.firstname,
    this.lastname,
    this.phoneNumber,
    this.userRole,
  );

  // Convert User object to a JSON-encodable map
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'companyId': companyId,
      'departmentId': departmentId,
      'email': email,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
      'phoneNumber': phoneNumber,
      'userRole': userRole,
    };
  }
}

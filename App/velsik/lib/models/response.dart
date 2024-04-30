class Response {
  int? responseId;
  int? questionId;
  int? userId;
  bool? answer;
  String? comment;
  String? questionTitle;
  String? questionText;

  Response(
    this.responseId,
    this.questionId,
    this.userId,
    this.answer,
    this.comment,
  );

  // Convert Question object to a JSON-encodable map
  Map<String, dynamic> toJson() {
    return {
      'responseId': responseId,
      'questionId': questionId,
      'userId': userId,
      'answer': answer,
      'comment': comment,
    };
  }
  
}

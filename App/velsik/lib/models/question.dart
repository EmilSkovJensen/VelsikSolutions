
class Question {
  int? questionId;
  int? apvId;
  int? apvTypeId;
  String questionTitle;
  String questionText;
  int? trueCount;
  int? falseCount;
  List<String>? comments;

  Question(
    this.questionId,
    this.apvId,
    this.apvTypeId,
    this.questionTitle,
    this.questionText,
  );

  // Convert Question object to a JSON-encodable map
  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'apvId': apvId,
      'apvTypeId': apvTypeId,
      'questionTitle': questionTitle,
      'questionText': questionText,
    };
  }
  
}


class Questions {
  String questionID;
  String name;
  String solution;
  String quizId;
  String quizName;
  String isLocked;
  String status;
  String createdDate;
  String modifiedDate;

  Questions({
    this.questionID,
    this.name,
    this.solution,
    this.quizId,
    this.quizName,
    this.isLocked,
    this.status,
    this.createdDate,
    this.modifiedDate,
  });

  factory Questions.fromJson(Map<String, dynamic> item) {
    return Questions(
        questionID: item['id'],
        name: item['name'],
        solution: item['solution'],
        quizId: item['quizId'],
        quizName: item['quizName'],
        isLocked: item['isLocked'] != false ? 'YES' : 'NO',
        status: item['status'],
        createdDate: item['createdDate'],
        modifiedDate: item['modifiedDate'] != null ? item['modifiedDate'] : null
    );
  }
}

class QuestionForListing {
  String questionID;
  String name;
  String quizName;
  String createdDate;
  String modifiedDate;

  QuestionForListing({
    this.questionID,
    this.name,
    this.quizName,
    this.createdDate,
    this.modifiedDate,
  });

  factory QuestionForListing.fromJson(Map<String, dynamic> item) {
    return QuestionForListing(
        questionID: item['id'],
        name: item['name'],
        quizName: item['quizName'],
        createdDate: item['createdDate'],
        modifiedDate: item['modifiedDate'] != null ? item['modifiedDate'] : null
    );
  }
}

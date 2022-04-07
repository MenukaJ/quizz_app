class QuizForListing {
  String quizID;
  String quizName;
  String categoryName;
  String createdDate;
  String modifiedDate;

  QuizForListing({
    this.quizID,
    this.quizName,
    this.categoryName,
    this.createdDate,
    this.modifiedDate,
  });

  factory QuizForListing.fromJson(Map<String, dynamic> item) {
    return QuizForListing(
        quizID: item['id'],
        quizName: item['name'],
        categoryName: item['categoryName'],
        createdDate: item['createdDate'],
        modifiedDate: item['modifiedDate'] != null ? item['modifiedDate'] : null
    );
  }
}

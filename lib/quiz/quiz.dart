class Quiz {
  String quizID;
  String name;
  String description;
  String categoryId;
  String categoryName;
  String status;
  String createdDate;
  String modifiedDate;

  Quiz({
    this.quizID,
    this.name,
    this.description,
    this.categoryId,
    this.categoryName,
    this.status,
    this.createdDate,
    this.modifiedDate,
  });

  factory Quiz.fromJson(Map<String, dynamic> item) {
    return Quiz(
        quizID: item['id'],
        name: item['name'],
        description: item['description'],
        categoryId: item['categoryId'],
        categoryName: item['categoryName'],
        status: item['status'],
        createdDate: item['createdDate'],
        modifiedDate: item['modifiedDate'] != null ? item['modifiedDate'] : null
    );
  }
}

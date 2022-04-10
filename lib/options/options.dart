class Options {
  String optionID;
  String name;
  String code;
  String questionId;
  String questionName;
  String isCorrect;
  String status;
  String createdDate;
  String modifiedDate;

  Options({
    this.optionID,
    this.name,
    this.code,
    this.questionId,
    this.questionName,
    this.isCorrect,
    this.status,
    this.createdDate,
    this.modifiedDate,
  });

  factory Options.fromJson(Map<String, dynamic> item) {
    return Options(
        optionID: item['id'],
        name: item['name'],
        code: item['code'],
        questionId: item['questionId'],
        questionName: item['questionName'],
        isCorrect: item['isCorrect'] != false ? 'YES' : 'NO',
        status: item['status'],
        createdDate: item['createdDate'],
        modifiedDate: item['modifiedDate'] != null ? item['modifiedDate'] : null
    );
  }
}
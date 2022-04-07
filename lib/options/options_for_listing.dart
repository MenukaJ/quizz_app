class OptionsForListing {
  String optionID;
  String name;
  String code;
  String questionName;
  String createdDate;
  String modifiedDate;

  OptionsForListing({
    this.optionID,
    this.name,
    this.code,
    this.questionName,
    this.createdDate,
    this.modifiedDate,
  });

  factory OptionsForListing.fromJson(Map<String, dynamic> item) {
    return OptionsForListing(
        optionID: item['id'],
        name: item['name'],
        code: item['code'],
        questionName: item['questionName'],
        createdDate: item['createdDate'],
        modifiedDate: item['modifiedDate'] != null ? item['modifiedDate'] : null
    );
  }
}

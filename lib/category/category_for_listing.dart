class CategoryForListing {
  String categoryID;
  String categoryName;
  String createdDate;
  String modifiedDate;

  CategoryForListing({
    this.categoryID,
    this.categoryName,
    this.createdDate,
    this.modifiedDate,
  });

  factory CategoryForListing.fromJson(Map<String, dynamic> item) {
    return CategoryForListing(
        categoryID: item['id'],
        categoryName: item['name'],
        createdDate: item['createdDate'],
        modifiedDate: item['modifiedDate'] != null ? item['modifiedDate'] : null
    );
  }
}

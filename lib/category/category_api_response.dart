class CategoryAPIResponse<T> {
  T data;
  bool error;
  String errorMessage;

  CategoryAPIResponse({
    this.data,
    this.errorMessage,
    this.error = false
  });
}
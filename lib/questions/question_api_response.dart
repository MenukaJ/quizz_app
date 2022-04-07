class QuestionAPIResponse<T> {
  T data;
  bool error;
  String errorMessage;

  QuestionAPIResponse({
    this.data,
    this.errorMessage,
    this.error = false
  });
}
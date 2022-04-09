class QuizAPIResponse<T> {
  T data;
  bool error;
  String errorMessage;

  QuizAPIResponse({
    this.data,
    this.errorMessage,
    this.error = false
  });

}
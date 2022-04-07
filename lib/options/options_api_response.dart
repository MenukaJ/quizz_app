class OptionsAPIResponse<T> {
  T data;
  bool error;
  String errorMessage;

  OptionsAPIResponse({
    this.data,
    this.errorMessage,
    this.error = false
  });
}
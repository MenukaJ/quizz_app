class NoteAPIResponse<T> {
  T data;
  bool error;
  String errorMessage;

  NoteAPIResponse({
    this.data,
    this.errorMessage,
    this.error = false
  });
}
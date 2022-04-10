class Response {
  String message;

  Response({this.message});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(message: json['messages']);
  }
}

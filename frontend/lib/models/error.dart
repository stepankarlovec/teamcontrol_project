class ErrorRequest {
  final String message;
  final String error;

  const ErrorRequest({
    required this.message,
    required this.error,
  });

  factory ErrorRequest.fromJson(Map<String, dynamic> json) {
    return ErrorRequest(
      message: json['message'],
      error: json['error'],
    );
  }
}
class DefaultRequest {
  final String message;

  const DefaultRequest({
    required this.message,
  });

  factory DefaultRequest.fromJson(Map<String, dynamic> json) {
    return DefaultRequest(
        message: json['message'],
    );
  }
}
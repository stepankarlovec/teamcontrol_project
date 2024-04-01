import 'dart:convert';
import 'package:app/config/globals.dart' as globals;
import 'package:http/http.dart' as http;

class LoginRequest {
  final bool success;
  final String token;
  final String message;
  final String error;

  const LoginRequest({
    required this.success,
    required this.token,
    required this.message,
    required this.error,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
        success: json['token']!=null ? true : false,
        token: json['token'] ?? '',
        message: json['message'],
        error: json['token']==null ? json['error'] : ''
    );
  }
}

Future<LoginRequest> createLoginRequest(
    String email, String password) async {
  final response = await http.post(
    Uri.parse('${globals.SERVER_DOMAIN}/api/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'device_name': 'android_phone'
    }),
  );
print(response.body);
  if (response.statusCode == 201) {
    return LoginRequest.fromJson(jsonDecode(response.body));
  } else {
    return LoginRequest.fromJson(jsonDecode(response.body));
  }
}

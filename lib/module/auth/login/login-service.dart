import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginService {
  Future<bool> postLogin(String email, String password) async {
    final url = Uri.parse('https://example.com/login');

    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      bool loginSuccess = responseData['loginSuccess'];
      return loginSuccess;
    } else {
      throw Exception('Login request failed with status: ${response.statusCode}');
    }
  }
}

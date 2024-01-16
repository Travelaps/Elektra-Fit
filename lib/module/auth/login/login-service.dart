import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginService {
  Future<bool> postLogin(String email, String password) async {
    final url = Uri.parse('https://4001.hoteladvisor.net/apisequence/SPAFitnessLogin');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'EMAIL': email,
          'PASSWORD': password,
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}

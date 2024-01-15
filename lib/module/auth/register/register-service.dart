import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../global/global-variables.dart';

class RegisterService {
  Future<bool> postRegister(String email, String name, String surname, String password, String phone) async {
    final url = 'YOUR_API_ENDPOINT';

    Map<String, dynamic> requestData = {
      "hotelid": config.hotelId,
      "password": password,
      "email": email,
      "name": name,
      "surname": surname,
      "phone": phone,
    };

    final response = await http.post(
      Uri.parse(url),
      body: json.encode(requestData),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      return true;
    } else {
      print('Error: ${response.reasonPhrase}');
      return false; // Return false if registration failed
    }
  }
}

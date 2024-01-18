import 'dart:convert';

import 'package:elektra_fit/global/global-models.dart';
import 'package:http/http.dart' as http;

import '../../../global/global-variables.dart';

class LoginService {
  Future<RequestResponse?> postLogin(String email, String password) async {
    fitness$.add(null);
    final url = Uri.parse('https://4001.hoteladvisor.net/apisequence/SPAFitnessLogin?EMAIL=$email&PASSWORD=$password');

    try {
      final response = await http.post(url, body: {});

      // print(response.body); // Output for debugging

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));

        if (jsonData != "KullanÄ±cÄ± BulunamadÄ±!") {
          List<FitnessModal> fitnesList = [];

          for (var item in jsonData) {
            fitnesList.add(FitnessModal.fromMap(item));
          }

          fitness$.add(fitnesList);
          fitness$.add(fitness$.value);

          return RequestResponse(message: "Login successfully", result: true);
        } else {
          return RequestResponse(message: "Kullanıcı Bulunamadı!", result: false);
        }
      } else {
        return RequestResponse(message: "An error occurred while logging in", result: false);
      }
    } catch (e) {
      print(e); // Output for debugging
      return RequestResponse(message: e.toString(), result: false);
    }
  }
}

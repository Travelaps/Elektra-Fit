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
      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        //
        // if (jsonData != "KullanÄ±cÄ± BulunamadÄ±!") {
        //   List<FitnessModel> fitnesList = [];
        //
        //   for (var item in jsonData) {
        //     fitnesList.add(FitnessModel.fromMap(item));
        //   }

        List<FitnessModel> fitnesList = [];

        for (var item in jsonData) {
          fitnesList.add(FitnessModel.fromMap(item));
        }

        fitness$.add(fitnesList);
        fitness$.add(fitness$.value);

        return RequestResponse(message: jsonData.toString(), result: true);
      }
    } catch (item) {
      return RequestResponse(message: item.toString(), result: false);
    }
  }
}

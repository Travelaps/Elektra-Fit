import 'dart:convert';

import 'package:elektra_fit/global/global-models.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import '../../../global/global-variables.dart';

class LoginService {
  BehaviorSubject<List<SpaMemberBodyAnalityModel>?> spaMemberBody$ = BehaviorSubject.seeded(null);

  Future<RequestResponse?> postLogin(String email, String password) async {
    member$.add(null);
    final url = Uri.parse('https://4001.hoteladvisor.net/apisequence/SPAFitnessLogin?EMAIL=$email&PASSWORD=$password');

    try {
      final response = await http.post(url, body: {});
      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        List<MemberModel> fitnesList = [];
        for (var item in jsonData) {
          fitnesList.add(MemberModel.fromJson(item));
        }
        member$.add(fitnesList);
        member$.add(member$.value);

        return RequestResponse(message: jsonData.toString(), result: true);
      }
    } catch (item) {
      return RequestResponse(message: item.toString(), result: false);
    }
    return null;
  }

  Future<RequestResponse?> spaMemberBodyAnality(String email, String password) async {
    spaMemberBody$.add(null);
    final url = Uri.parse('https://4001.hoteladvisor.net');
    try {
      final response = await http.post(url, body: {
        "Action": "ApiSequence",
        "Object": "spaMemberBodyAnalysisList",
        "Parameters": {"HOTELID": member$.value?.first.profile.hotelid}
      });
      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));

        List<SpaMemberBodyAnalityModel> spaMemberBody = [];

        for (var item in jsonData) {
          spaMemberBody.add(SpaMemberBodyAnalityModel.fromJson(item));
        }
        spaMemberBody$.add(spaMemberBody);
        spaMemberBody$.add(spaMemberBody$.value);

        return RequestResponse(message: jsonData.toString(), result: true);
      }
    } catch (item) {
      return RequestResponse(message: item.toString(), result: false);
    }
    return null;
  }
}

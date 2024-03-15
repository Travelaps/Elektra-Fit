import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import '../../global/global-models.dart';
import '../../global/global-variables.dart';

class ProfileService {
  BehaviorSubject<List<SpaMemberBodyAnalysis?>?> spaMemberBody$ = BehaviorSubject.seeded(null);

  Future<RequestResponse?> spaMemberBodyAnality() async {
    final url = Uri.parse('https://4001.hoteladvisor.net');
    try {
      final response = await http.post(url,
          body: json.encode({
            "Action": "ApiSequence",
            "Object": "spaMemberBodyAnalysisList",
            "Parameters": {"HOTELID": member$.value?.first.profile.hotelid}
          }));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        List<SpaMemberBodyAnalysis> spaMemberBody = [];

        for (var item in jsonData) {
          spaMemberBody.add(SpaMemberBodyAnalysis.fromJson(item));
        }
        spaMemberBody$.add(spaMemberBody);
        spaMemberBody$.add(spaMemberBody$.value);

        return RequestResponse(message: jsonData.toString(), result: true);
      }
    } catch (item) {
      return RequestResponse(message: item.toString(), result: false);
    }
  }
}

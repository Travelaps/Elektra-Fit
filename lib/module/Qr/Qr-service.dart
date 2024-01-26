import 'dart:convert';

import 'package:elektra_fit/global/global-models.dart';
import 'package:elektra_fit/global/global-variables.dart';
import 'package:http/http.dart' as http;

class QrService {
  Future<RequestResponse> postQrScanner(String placeId) async {
    final url = Uri.parse('https://4001.hoteladvisor.net/apisequence/SPAFitnessLogin?PLACEID=$placeId&GUESTID=${fitness$.value?.first.profile?.guestid}&ENTRANCEDATE=${DateTime.now()}');

    try {
      final response = await http.post(url, body: {});
      if (response.statusCode >= 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        return RequestResponse(message: jsonData.toString(), result: false);
      } else {
        return RequestResponse(message: "An error occurred while logging in", result: false);
      }
    } catch (e) {
      return RequestResponse(message: "sjdasjdaksjdlaskj", result: false);
    }
  }
}

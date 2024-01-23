import 'dart:convert';

import 'package:elektra_fit/global/global-models.dart';
import 'package:http/http.dart' as http;

class QrService {
  Future<RequestResponse> postQrScanner(String placeId, int guestId, DateTime entranceDate) async {
    final url = Uri.parse('https://4001.hoteladvisor.net/apisequence/SPAFitnessLogin?PLACEID=$placeId&GUESTID=$guestId&ENTRANCEDATE=$entranceDate');

    try {
      final response = await http.post(url, body: {});
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
      } else {
        return RequestResponse(message: "An error occurred while logging in", result: false);
      }
    } catch (e) {
      return RequestResponse(message: "sjdasjdaksjdlaskj", result: false);
    }

    return RequestResponse(message: "hata", result: false);
  }
}

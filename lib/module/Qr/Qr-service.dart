import 'package:elektra_fit/global/index.dart';
import 'package:http/http.dart' as http;

import '../../global/global-models.dart';

class QrService {
  Future<RequestResponse> postQrScanner(String placeId, String formattedDate) async {
    final url = Uri.parse('https://4001.hoteladvisor.net/apisequence/SPAFitnessMemberEntrance?PLACEID=$placeId&GUESTID=${member$.value?.first.profile?.guestid}&ENTRANCEDATE=$formattedDate');
    try {
      final response = await http.post(url, body: {});
      return RequestResponse(message: utf8.decode(response.bodyBytes).tr(), result: true);
    } catch (e) {
      print(e);
      return RequestResponse(message: e.toString(), result: false);
    }
  }
}

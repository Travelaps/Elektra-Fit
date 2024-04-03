import 'package:http/http.dart' as http;

import '../../global/global-models.dart';
import '../../global/index.dart';

class PaymentService {
  Future<RequestResponse>? paymentSend(String cardName, String cardNo, String cardCvc, int month, int year) async {
    try {
      var response = await http.post(url,
          body: json.encode({
            "Action": "Execute",
            "Object": "SP_SAVESPACC",
            "Parameters": {
              "CCNO": cardNo,
              "CCNAME": cardName,
              "CCCV2": cardCvc,
              "MONTH": month,
              "YEAR": year,
              "HOTELID": hotelId,
              "SPARESID": "",
            }
          }));
      final jsonData = json.encode(response.body);
      return RequestResponse(message: "success", result: true);
    } catch (e) {
      print(e);
      return RequestResponse(message: "error", result: false);
    }
  }
}

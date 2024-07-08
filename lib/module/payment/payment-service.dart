class PaymentService {}

// import 'package:http/http.dart' as http;
//
// import '../../global/global-models.dart';
// import '../../global/index.dart';
//
// class PaymentService {
//   BehaviorSubject<List<PaymentGate?>?> paymentGate$ = BehaviorSubject.seeded(null);
//
//   bool checkLuhn(incStr) {
//     int sum = 0, count, cardNum;
//     for (count = 0; count < incStr.length; count++) {
//       cardNum = int.parse(incStr[count]);
//       if ((incStr.length - count) % 2 == 0) {
//         cardNum = cardNum * 2;
//         if (cardNum > 9) cardNum = cardNum - 9;
//       }
//       sum += cardNum;
//     }
//     if (sum % 10 == 0) return true;
//     return false;
//   }
//
//   getCreditCardNumber(String value) {
//     return value.replaceAll(' ', '');
//   }
//
//   Future<bool?> getPaymentGateOfBinNumber(String binNumber) async {
//     try {
//       paymentGate$.value = null;
//       var response = await http.post(url,
//           body: json.encode({
//             "Action": "Execute",
//             "Object": "SP_PORTALV4_GETPAYMENTGATEOFBINNUMBER",
//             "Parameters": {
//               "BINNUMBER": binNumber,
//               "PORTALID": 1,
//             }
//           }));
//
//       if (response.statusCode == 200) {
//         var jsonData = json.decode(utf8.decode(response.bodyBytes));
//         List<PaymentGate>? paymentGate = [];
//
//         jsonData[0].forEach((e) {
//           paymentGate.add(PaymentGate.fromJson(e));
//         });
//         paymentGate$.add(paymentGate);
//         paymentGate$.add(paymentGate$.value);
//         print(paymentGate$.value?.first?.id);
//         return true;
//       }
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }
//
//   Future<void> getInstallment(bool isDefaultPaymentGate, int paymentGateId) async {
//     try {
//       var response = await http.post(url,
//           body: json.encode({
//             "Action": "Execute",
//             "Object": "SP_PORTALV4_GETINSTALLMENT",
//             "Parameters": {
//               "CALLCENTERPOS": false,
//               "HOTELID": hotelId ?? 24204,
//               "ISDEBIT": true,
//               "ISDEFAULTPAYMENTGATE": isDefaultPaymentGate,
//               "PAYMENTGATEID": paymentGateId,
//               "PORTALID": 1,
//               "ROMMTYPEID": null,
//             }
//           }));
//
//       if (response.statusCode == 200) {
//         var data = json.decode(utf8.decode(response.bodyBytes));
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> bakiyem3dMakePost(
//     double amount,
//     String cardHolder,
//     String cardNo,
//     int cvc,
//     int expireMonth,
//     int expireYear,
//     String currency,
//     String basketUid,
//   ) async {
//     try {
//       var response = await http.post(url,
//           body: json.encode({
//             "Action": "ApiSequence",
//             'Object': "Bakiyem3DMakePost",
//             "Parameters": {
//               "AMOUNT": amount,
//               "BASKETUID": basketUid,
//               " BRAND": null,
//               "CARDHOLDER": cardHolder,
//               "CARDNO": cardNo,
//               "CURRENCY": currency,
//               "CVC": cvc,
//               "EMAIL": "a@a.com",
//               "EXPIREMOUNTH": expireMonth,
//               "EXPIREYEAR": expireYear,
//               "HOTELID": hotelId,
//               "INSTALLMENT": "1",
//               "LANGUAGE": "EN",
//               "OWNERADDRESS": "-",
//               "OWNERCITY": "-",
//               "OWNERTELNO": "-",
//               "OWNERTOWN": "-",
//               "OWNERZIP": "00000",
//               "PORTALID": 1,
//               // "POSID": posId,
//               // "RETURNURL": returnUrl,
//             },
//           }));
//
//       if (response.statusCode == 200) {
//         var data = json.decode(utf8.decode(response.bodyBytes));
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> saveContactRequest(String email, String cardName, String notes, String phone) async {
//     try {
//       var response = await http.post(url,
//           body: json.encode({
//             "Action": "Execute",
//             Object: "SP_PORTALV4_SAVECONTACTREQUEST",
//             "Parameters": {
//               "EMAIL": email,
//               "HOTELID": hotelId,
//               "ISPAYMENT": true,
//               "NAME": cardName,
//               "NOTES": notes,
//               "PHONE": phone,
//               "PORTALID": 1,
//               "RESUID": null,
//               "SESSION": null,
//               "SURNAME": "",
//             }
//           }));
//
//       if (response.statusCode == 200) {
//         var data = json.decode(utf8.decode(response.bodyBytes));
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> hotelTransaction(String email, String cardName, String notes, String phone) async {
//     try {
//       var response = await http.post(url, body: json.encode({"Action": "Select", "Object": "QB_HOTEL_TRANSACTION"}));
//
//       if (response.statusCode == 200) {
//         var data = json.decode(utf8.decode(response.bodyBytes));
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<RequestResponse>? paymentSend(String cardName, String cardNo, String cardCvc, int month, int year) async {
//     try {
//       var response = await http.post(url,
//           body: json.encode({
//             "Action": "Execute",
//             "Object": "SP_SAVESPACC",
//             "Parameters": {
//               "CCNO": cardNo,
//               "CCNAME": cardName,
//               "CCCV2": cardCvc,
//               "MONTH": month,
//               "YEAR": year,
//               "HOTELID": hotelId,
//               "SPARESID": "",
//             }
//           }));
//       final jsonData = json.encode(response.body);
//       return RequestResponse(message: "success", result: true);
//     } catch (e) {
//       print(e);
//       return RequestResponse(message: "error", result: false);
//     }
//   }
// }

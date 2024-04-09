import 'package:elektra_fit/global/index.dart';
import 'package:http/http.dart' as http;

import '../../global/global-models.dart';

class ProfileService {
  BehaviorSubject<String> selectedHours$ = BehaviorSubject.seeded("");
  BehaviorSubject<List<SpaMemberBodyAnalysis?>?> spaMemberBody$ = BehaviorSubject.seeded(null);
  BehaviorSubject<List<ReservationModel?>?> reservation$ = BehaviorSubject.seeded(null);
  BehaviorSubject<List<SpaService>?> spaService$ = BehaviorSubject.seeded(null);
  BehaviorSubject<int> paymentType$ = BehaviorSubject.seeded(0);
  BehaviorSubject<List<AvailabilityHours?>?> availabilityHours$ = BehaviorSubject.seeded(null);
  BehaviorSubject<DateTime?> selectDateAvailability$ = BehaviorSubject.seeded(null);
  BehaviorSubject<Map<String, List<ReservationModel>?>?> res$ = BehaviorSubject.seeded({"To be planned".tr(): [], "Planned".tr(): [], "Completed".tr(): []});
  BehaviorSubject<String> resId$ = BehaviorSubject.seeded("");

  Future<RequestResponse?> spaMemberBodyAnality() async {
    spaMemberBody$.add(null);
    try {
      final response = await http.post(url,
          body: json.encode({
            "Action": "ApiSequence",
            "Object": "spaMemberBodyAnalysisList",
            "Parameters": {"HOTELID": hotelId}
          }));
      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
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
    return null;
  }

  Future<RequestResponse?> operationList() async {
    res$.value = null;
    try {
      var response = await http.post(url,
          body: json.encode({
            "Action": "ApiSequence",
            "Object": "spaMemberReservationList",
            "Parameters": {"HOTELID": hotelId, "MEMBERID": member$.value?.first.profile.guestid}
          }));
      final jsonData = json.decode(utf8.decode(response.bodyBytes));
      if (jsonData != null) {
        var today = DateTime.now();
        res$.value = {"To be planned".tr(): [], "Planned".tr(): [], "Completed".tr(): []};
        jsonData.forEach((e) {
          ReservationModel reservation = ReservationModel.fromJson(e);

          if (reservation.resstart == null && reservation.resend == null) {
            res$.value?["To be planned".tr()]?.add(reservation);
          } else {
            if (reservation.resstart != null && reservation.resstart!.isBefore(today)) {
              res$.value?["Completed".tr()]?.sort((a, b) => a.resstart!.compareTo(b.resstart!));
              res$.value?["Completed".tr()]?.add(reservation);
            } else {
              res$.value?["Planned".tr()]?.sort((a, b) => a.resstart!.compareTo(b.resstart!));
              res$.value?["Planned".tr()]?.add(reservation);
            }
          }
        });
        res$.add(res$.value);
      }
      return RequestResponse(message: jsonData.toString(), result: true);
    } catch (item) {
      print(item);
      return RequestResponse(message: item.toString(), result: false);
    }
  }

  Future<RequestResponse?> availability(DateTime dateTime) async {
    try {
      var response = await http.post(
        url,
        body: json.encode({
          "Action": "Execute",
          "Object": "SP_SPA_AVAILABLETIMES",
          "Parameters": {"DATE": DateFormat("yyyy-MM-dd").format(dateTime), "HOTELID": 24204}
          //todo hotel id add
        }),
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        List<AvailabilityHours> availabilityList = [];
        for (var item in jsonData[0]) {
          availabilityList.add(AvailabilityHours.fromJson(item));
        }
        availabilityHours$.add(availabilityList);
        availabilityHours$.add(availabilityHours$.value);
      }
      return RequestResponse(message: "success", result: true);
    } catch (e) {
      print(e);
      return RequestResponse(message: e.toString(), result: false);
    }
  }

  Future<RequestResponse?> spaInfo() async {
    spaService$.add(null);
    try {
      var response = await http.post(url,
          body: json.encode({
            "Action": "Execute",
            "Object": "SP_SPA_INFO",
            "Parameters": {"HOTELID": 24204}
          }));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

        for (var item in data) {
          item.forEach((subItem) {
            String hotelInfos = subItem['HOTELINFOS'];
            Map<String, dynamic> hotelInfoDict = json.decode(hotelInfos);
            List<dynamic> spaServices = hotelInfoDict['SPA_SERVICES'];
            List<SpaService> spaServiceList = [];
            for (var service in spaServices) {
              SpaService spaService = SpaService.fromJson(service);
              spaServiceList.add(spaService);
            }
            spaService$.add(spaServiceList);
            spaService$.add(spaService$.value);
          });
        }
      }
    } catch (e) {
      print(e);
      return RequestResponse(message: "Bir hata oluştu: ${e.toString()}", result: false);
    }
    return null;
  }

  Future<RequestResponse?> reservationCreate(String fullName, String phone, DateTime resStart, SpaService spaService, int paymentType) async {
    try {
      var response = await http.post(url,
          body: json.encode({
            "Action": "Execute",
            "Object": "SP_SPA_SAVE_RES",
            "Parameters": {
              "CCID": null,
              "CURRENCYID": spaService.currencyid,
              "FULLNAME": fullName,
              "HOTELID": 24204,
              "PAYMENTTYPE": paymentType,
              "PHONE": phone,
              "PRICE": spaService.price,
              "RESSTART": DateFormat("yyyy-MM-dd").format(resStart),
              "SERVICEID": spaService.id
            }
          }));

      var jsonData = json.decode(utf8.decode(response.bodyBytes));
      if (jsonData[0][0]["SUCCESS"] == 1) {
        var data = jsonData[0][0]["SPARESID"];
        resId$.add(data);
        return RequestResponse(message: "success", result: true);
      }

      return RequestResponse(message: jsonData[0][0]["MESSAGE"], result: false);
    } catch (e) {
      print(e);
      return RequestResponse(message: "error", result: false);
    }
  }
}

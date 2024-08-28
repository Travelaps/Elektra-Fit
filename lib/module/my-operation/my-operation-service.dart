import 'package:elektra_fit/global/global-models.dart';
import 'package:elektra_fit/global/index.dart';
import 'package:http/http.dart' as http;

class MyOperationsService {
  BehaviorSubject<List<SpaService>?> spaService$ = BehaviorSubject.seeded(null);
  BehaviorSubject<int> paymentType$ = BehaviorSubject.seeded(0);
  BehaviorSubject<String> selectedHours$ = BehaviorSubject.seeded("");
  BehaviorSubject<List<AvailabilityHours?>?> availabilityHours$ = BehaviorSubject.seeded(null);
  BehaviorSubject<DateTime?> selectDateAvailability$ = BehaviorSubject.seeded(null);
  BehaviorSubject<Map<String, List<ReservationModel>?>?> res$ =
      BehaviorSubject.seeded({"To be planned".tr(): [], "Planned".tr(): [], "Completed".tr(): []});
  BehaviorSubject<int> resId$ = BehaviorSubject.seeded(0);

  Future<RequestResponse?> lastSpaBooking() async {
    res$.value = null;
    try {
      var response = await http.post(apiUrl,
          body: json.encode({
            "Action": "ApiSequence",
            "Object": "spaMemberReservationList",
            "Parameters": {"HOTELID": hotelId, "MEMBERID": member$.value?.first.profile.guestid}
          }));
      final jsonData = json.decode(utf8.decode(response.bodyBytes));
      if (jsonData != null) {
        var today = DateTime.now();
        res$.value = {"To be planned".tr(): [], "Completed".tr(): []};
        jsonData.forEach((e) {
          ReservationModel reservation = ReservationModel.fromJson(e);

          if (reservation.resstart == null && reservation.resend == null) {
            res$.value?["To be planned".tr()]?.add(reservation);
          } else {
            if (reservation.resstart != null && reservation.resstart!.isBefore(today)) {
              res$.value?["Completed".tr()]?.sort((a, b) => a.resstart!.compareTo(b.resstart!));
              res$.value?["Completed".tr()]?.add(reservation);
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
        apiUrl,
        body: json.encode({
          "Action": "Execute",
          "Object": "SP_SPA_AVAILABLETIMES",
          "Parameters": {"DATE": DateFormat("yyyy-MM-dd").format(dateTime), "HOTELID": hotelId}
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
      var response = await http.post(apiUrl,
          body: json.encode({
            "Action": "Execute",
            "Object": "SP_SPA_INFO",
            "Parameters": {"HOTELID": hotelId}
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

  Future<RequestResponse?> reservationCreate(String fullName, String phone, DateTime resStartDate, SpaService spaService, int paymentType) async {
    try {
      var response = await http.post(apiUrl,
          body: json.encode({
            "Action": "Execute",
            "Object": "SP_SPA_SAVE_RES",
            "Parameters": {
              "CCID": null,
              "CURRENCYID": spaService.currencyid,
              "FULLNAME": fullName,
              "HOTELID": hotelId,
              "PAYMENTTYPE": paymentType,
              "PHONE": phone,
              "PRICE": spaService.price,
              "RESHOURS": selectedHours$.value,
              "RESSTART": resStartDate.toIso8601String(),
              "SERVICEID": spaService.id,
              "DEPARTMENTID": null
            }
          }));

      var jsonData = json.decode(utf8.decode(response.bodyBytes));
      if (jsonData[0][0]["SUCCESS"] == 1) {
        var data = jsonData[0][0]["SPARESID"];
        resId$.add(data);
        resId$.add(resId$.value);
        return RequestResponse(message: "success", result: true);
      } else if (jsonData[0][0]["SUCCESS"] == 0) {
        return RequestResponse(message: jsonData[0][0]["MESSAGE"], result: false);
      }
      return RequestResponse(message: jsonData, result: false);
    } catch (e) {
      print(e);
      return RequestResponse(message: e.toString(), result: false);
    }
  }
}

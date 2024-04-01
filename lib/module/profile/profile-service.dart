import 'package:elektra_fit/global/index.dart';
import 'package:http/http.dart' as http;

import '../../global/global-models.dart';

class ProfileService {
  BehaviorSubject<List<SpaMemberBodyAnalysis?>?> spaMemberBody$ = BehaviorSubject.seeded(null);
  BehaviorSubject<List<ReservationModel?>?> reservation$ = BehaviorSubject.seeded(null);
  BehaviorSubject<List<SpaInfoModel?>?> spaInfo$ = BehaviorSubject.seeded(null);
  BehaviorSubject<List<SpaInfoModels?>?> spaInfos$ = BehaviorSubject.seeded(null);
  BehaviorSubject<List<AvailabilityHours?>?> availabilityHours$ = BehaviorSubject.seeded(null);
  BehaviorSubject<DateTime?> selectDateAvailability$ = BehaviorSubject.seeded(null);

  BehaviorSubject<Map<String, List<ReservationModel>?>?> res$ = BehaviorSubject.seeded({"To be planned".tr(): [], "Planned".tr(): [], "Completed".tr(): []});

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
      var response = await http.post(url,
          body: json.encode({
            "Action": "Execute",
            "Object": "SP_SPA_AVAILABLETIMES",
            "Parameters": {"DATE": DateTime, "HOTELID": 24204}
            //todo hotel id add
          }));
      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        List<AvailabilityHours> availabilityList = [];
        for (var item in jsonData) {
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

  BehaviorSubject<List<Map<String, dynamic>?>?> spainfos$ = BehaviorSubject.seeded(null);

  Future<RequestResponse?> spaInfo() async {
    try {
      var response = await http.post(url,
          body: json.encode({
            "Action": "Execute",
            "Object": "SP_SPA_INFO",
            "Parameters": {"HOTELID": 24204}
          }));

      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        if (jsonData is List && jsonData.isNotEmpty) {
          List<SpaInfoModels> spaInfoModelsList = [];
          for (var item in jsonData[0]) {
            if (item.containsKey("hotelInfos")) {
              SpaInfoModels spaInfoModel = SpaInfoModels.fromJson(item["hotelInfos"]);
              spaInfoModelsList.add(spaInfoModel);
            }
          }
          spaInfos$.add(spaInfoModelsList);
          print(spaInfos$.value?.first?.hotelinfos.length);
          return RequestResponse(message: "Veri başarıyla alındı", result: true);
        } else {
          return RequestResponse(message: "Boş veri döndü", result: false);
        }
      } else {
        return RequestResponse(message: "Veri alınamadı. Durum kodu: ${response.statusCode}", result: false);
      }
    } catch (e) {
      print(e);
      return RequestResponse(message: "Bir hata oluştu: ${e.toString()}", result: false);
    }
  }
}

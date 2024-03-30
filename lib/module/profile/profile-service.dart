import 'package:elektra_fit/global/index.dart';
import 'package:http/http.dart' as http;

import '../../global/global-models.dart';

class ProfileService {
  BehaviorSubject<List<SpaMemberBodyAnalysis?>?> spaMemberBody$ = BehaviorSubject.seeded(null);
  BehaviorSubject<List<ReservationModel?>?> reservation$ = BehaviorSubject.seeded(null);
  BehaviorSubject<List<SpaInfoModel?>?> spaInfo$ = BehaviorSubject.seeded(null);
  BehaviorSubject<List<AvailabilityHours?>?> availabilityHours$ = BehaviorSubject.seeded(null);
  BehaviorSubject<DateTime> selectDateAvailability$ = BehaviorSubject.seeded(DateTime.now());

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
    return null;
  }

  Future<RequestResponse?> spaInfo() async {
    try {
      var response = await http.post(url,
          body: json.encode({
            "Action": "Execute",
            "Object": "SP_SPA_INFO",
            "Parameters": {"HOTELID": 24204}
            // todo hotel id add
          }));

      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));

        if (jsonData is List && jsonData.isNotEmpty) {
          final firstItem = jsonData[0];
          if (firstItem is List && firstItem.isNotEmpty) {
            final firstItemMap = firstItem[0];
            if (firstItemMap != null && firstItemMap is Map<String, dynamic> && firstItemMap.containsKey('HOTELINFOS')) {
              final hotelInfos = firstItemMap['HOTELINFOS'];
              if (hotelInfos != null && hotelInfos is Iterable) {
                List<SpaInfoModel> spaInfoList = [];
                for (var item in hotelInfos) {
                  spaInfoList.add(SpaInfoModel.fromJson(item));
                }
                spaInfo$.add(spaInfoList);
                spaInfo$.add(spaInfo$.value);
                return RequestResponse(message: "success", result: true);
              }
            }
          }
        }
        // JSON verisi beklendiği gibi değilse veya gerekli bilgiler yoksa:
        return RequestResponse(message: "No spa information found", result: false);
      } else {
        print("a");
        return RequestResponse(message: "Invalid response format", result: false);
      }
    } catch (e) {
      // Hata varsa:
      print(e); // Hatanın nedenini görmek için konsola yazdırabilirsiniz.
      return RequestResponse(message: "An error occurred: ${e.toString()}", result: false);
    }
  }
}

import 'package:elektra_fit/global/index.dart';
import 'package:http/http.dart' as http;

import '../../global/global-models.dart';

class ProfileService {
  BehaviorSubject<List<SpaMemberBodyAnalysis?>?> spaMemberBody$ = BehaviorSubject.seeded(null);
  BehaviorSubject<List<ReservationModel?>?> reservation$ = BehaviorSubject.seeded(null);

  BehaviorSubject<Map<String, List<ReservationModel>?>?> res$ = BehaviorSubject.seeded({
    "Past".tr(): [],
    "Upcoming".tr(): [],
    "Planned".tr(): [],
  });

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

  Future<RequestResponse?> ressList() async {
    res$.value == null;
    try {
      var response = await http.post(url,
          body: json.encode({
            "Action": "ApiSequence",
            "Object": "spaMemberReservationList",
            "Parameters": {"HOTELID": hotelId, "MEMBERID": member$.value?.first.profile.guestid}
          }));
      final jsonData = json.decode(utf8.decode(response.bodyBytes));
      res$.value = {"Past".tr(): [], "Upcoming".tr(): [], "Planned".tr(): []};
      var today = DateTime.now();
      if (jsonData != null) {
        if (res$.value != null) {
          jsonData.forEach((e) {
            ReservationModel reservation = ReservationModel.fromJson(e);

            if (reservation.resstart != null && reservation.resend != null) {
              if (reservation.resstart!.isBefore(today)) {
                res$.value?["Upcoming".tr()]?.add(reservation);
              }
              if (reservation.resstart!.isAfter(today)) {
                res$.value?["Past".tr()]?.add(reservation);
              }
              res$.value?["Planned".tr()]?.add(reservation);
            }
            // if (reservation.resstart != null && reservation.resend != null) {
            //   if (reservation.resstart!.isBefore(today)) {
            //     res$.value?["Past".tr()]?.add(reservation);
            //   } else if (reservation.resstart!.isAfter(today)) {
            //     res$.value?["Upcoming".tr()]?.add(reservation);
            //   }
            // }
            // res$.value?["Planned".tr()]?.add(reservation);
          });

          res$.add(res$.value);
        }
      }
      return RequestResponse(message: jsonData.toString(), result: true);
    } catch (item) {
      return RequestResponse(message: item.toString(), result: false);
    }
  }
}

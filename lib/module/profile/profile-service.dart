import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import '../../global/global-models.dart';
import '../../global/global-variables.dart';

class ProfileService {
  BehaviorSubject<List<SpaMemberBodyAnalysis?>?> spaMemberBody$ = BehaviorSubject.seeded(null);
  BehaviorSubject<List<ReservationModel?>?> reservation$ = BehaviorSubject.seeded(null);

  BehaviorSubject<Map<String, List<ReservationModel>?>?> res$ = BehaviorSubject.seeded(null);

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

  // Future<RequestResponse?> reservationList() async {
  //   reservation$.add(null);
  //   try {
  //     final response = await http.post(url,
  //         body: json.encode({
  //           "Action": "ApiSequence",
  //           "Object": "spaMemberReservationList",
  //           "Parameters": {"HOTELID": hotelId, "MEMBERID": member$.value?.first.profile.guestid}
  //         }));
  //     final jsonData = json.decode(utf8.decode(response.bodyBytes));
  //     if (jsonData != null) {
  //       List<ReservationModel> reservation = [];
  //
  //       for (var item in jsonData) {
  //         reservation.add(ReservationModel.fromJson(item));
  //       }
  //       reservation$.add(reservation);
  //       return RequestResponse(message: jsonData.toString(), result: true);
  //     }
  //   } catch (item) {
  //     return RequestResponse(message: item.toString(), result: false);
  //   }
  //
  //   return null;
  // }

  Future<RequestResponse?> ressList() async {
    res$.value = {"Past": [], "Future": [], "Planning": []};
    try {
      final response = await http.post(url,
          body: json.encode({
            "Action": "ApiSequence",
            "Object": "spaMemberReservationList",
            "Parameters": {"HOTELID": hotelId, "MEMBERID": member$.value?.first.profile.guestid}
          }));
      final jsonData = json.decode(utf8.decode(response.bodyBytes));

      if (jsonData != null) {
        final today = DateTime.now().toUtc(); // Use UTC for consistent comparison

        jsonData.forEach((e) {
          final reservation = ReservationModel.fromJson(e);

          if (reservation.resstart.isBefore(today)) {
            res$.value?["Past"]?.add(reservation);
          } else if (reservation.resstart.isAfter(today)) {
            res$.value?["Future"]?.add(reservation);
          }
        });

        res$.add(res$.value);
        return RequestResponse(message: jsonData.toString(), result: true);
      }
    } catch (item) {
      return RequestResponse(message: item.toString(), result: false);
    }

    return null;
  }
}

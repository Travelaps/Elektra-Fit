import 'package:http/http.dart' as http;

import '../../global/global-models.dart';
import '../../global/index.dart';

class HomeService {
  BehaviorSubject<List<SpaGroupActivityModel>?> spaGroupActivity$ = BehaviorSubject.seeded(null);
  BehaviorSubject<List<SpaGroupActivityMemberListModel>?> spaGroupActivityMember$ = BehaviorSubject.seeded(null);
  BehaviorSubject<DateTime> selectedDate$ = BehaviorSubject.seeded(DateTime.now());
  BehaviorSubject<bool> isFilter$ = BehaviorSubject.seeded(false);
  List<SpaGroupActivityModel> total = [];
  List<SpaGroupActivityModel> totalFilter = [];

  Future<RequestResponse> spaGroupActivityTimetableList() async {
    spaGroupActivity$.add(null);

    try {
      final response = await http.post(apiUrl,
          body: json.encode({
            "Action": "ApiSequence",
            "Object": "spaGroupActivityTimetableList",
            "Parameters": {"HOTELID": hotelId}
          }));

      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        List<SpaGroupActivityModel> spaGroupActivity = [];
        for (var item in jsonData) {
          spaGroupActivity.add(SpaGroupActivityModel.fromJson(item));
        }

        spaGroupActivity$.add(spaGroupActivity);
        spaGroupActivity$.add(spaGroupActivity$.value);
      }

      return RequestResponse(message: utf8.decode(response.bodyBytes).tr(), result: true);
    } catch (e) {
      print(e);
      return RequestResponse(message: e.toString(), result: false);
    }
  }

  Future<RequestResponse> spaGroupActivityTimetableMembersList() async {
    spaGroupActivityMember$.add(null);

    try {
      final response = await http.post(apiUrl,
          body: json.encode({
            "Action": "ApiSequence",
            "Object": "spaGroupActivityTimetableMembersList",
            "Parameters": {"HOTELID": hotelId}
          }));

      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        List<SpaGroupActivityMemberListModel> spaGroupMember = [];

        for (var item in jsonData) {
          spaGroupMember.add(SpaGroupActivityMemberListModel.fromJson(item));
        }
        spaGroupMember.sort((a, b) {
          var startTimeA = a.startTime ?? DateTime(0);
          var startTimeB = b.startTime ?? DateTime(0);
          return startTimeB.compareTo(startTimeA);
        });

        spaGroupActivityMember$.add(spaGroupMember);
        spaGroupActivityMember$.add(spaGroupActivityMember$.value);
      }

      return RequestResponse(message: utf8.decode(response.bodyBytes).tr(), result: true);
    } catch (e) {
      return RequestResponse(message: e.toString(), result: false);
    }
  }

  Future<RequestResponse> spaGroupActivityTimeTableMemberInsert(int timeTableId) async {
    try {
      var response = await http.post(apiUrl,
          body: json.encode({
            "Action": "ApiSequence",
            "Object": "spaGroupActivityTimetableMemberInsert",
            "Parameters": {"HOTELID": hotelId, "TIMETABLEID": timeTableId, "MEMBERID": member$.value?.first.profile.guestid}
          }));
      var jsonData = json.decode(response.body);
      if (jsonData["Success"] == 1) {
        return RequestResponse(message: "Congratulations! You have successfully participated in the activity.".tr(), result: true);
      } else if (jsonData["Success"] == 0) {
        return RequestResponse(message: jsonData["Message".tr()], result: false);
      }
    } catch (e) {
      print(e);
      return RequestResponse(message: e.toString(), result: false);
    }
    return RequestResponse(message: "", result: false);
  }
}

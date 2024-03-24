import 'package:http/http.dart' as http;

import '../../global/global-models.dart';
import '../../global/index.dart';

class HomeService {
  BehaviorSubject<List<SpaGroupActivityModel>?> spaGroupActivity$ = BehaviorSubject.seeded(null);

  Future<RequestResponse> spaGroupActivityTimetableList() async {
    spaGroupActivity$.add(null);

    try {
      final response = await http.post(url,
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

  Future<RequestResponse> spaGroupActivityTimetableMemberInsert(int timeTableId) async {
    try {
      var response = await http.post(url,
          body: json.encode({
            "Action": "ApiSequence",
            "Object": "spaGroupActivityTimetableMemberInsert",
            "Parameters": {"HOTELID": hotelId, "TIMETABLEID": timeTableId, "MEMBERID": member$.value?.first.profile.guestid, "HOTELID": hotelId}
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

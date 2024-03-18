import 'package:http/http.dart' as http;

import '../../global/global-models.dart';
import '../../global/index.dart';

class MyProgramingService {
  BehaviorSubject<List<SpaGroupActivityMemberListModel>?> spaGroupActivityMember$ = BehaviorSubject.seeded(null);

  Future<RequestResponse> spaGroupActivityTimetableMembersList() async {
    spaGroupActivityMember$.add(null);
    final url = Uri.parse('https://4001.hoteladvisor.net');
    try {
      final response = await http.post(url,
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
       
        spaGroupActivityMember$.add(spaGroupMember);
        spaGroupActivityMember$.add(spaGroupActivityMember$.value);
      }

      return RequestResponse(message: utf8.decode(response.bodyBytes).tr(), result: true);
    } catch (e) {
      print(e);
      return RequestResponse(message: e.toString(), result: false);
    }
  }
}

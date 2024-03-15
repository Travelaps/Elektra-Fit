class RequestResponse {
  String message;
  bool result;

  RequestResponse({required this.message, required this.result});
}

class MemberModel {
  Profile profile;
  List<Program> program;
  dynamic membership;

  MemberModel({
    required this.profile,
    required this.program,
    required this.membership,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        profile: Profile.fromJson(json["PROFILE"]),
        program: List<Program>.from(json["PROGRAM"].map((x) => Program.fromJson(x))),
        membership: json["MEMBERSHIP"],
      );

  Map<String, dynamic> toJson() => {
        "PROFILE": profile.toJson(),
        "PROGRAM": List<dynamic>.from(program.map((x) => x.toJson())),
        "MEMBERSHIP": membership,
      };
}

class Profile {
  int guestid;
  String email;
  String fullname;
  dynamic photourl;
  dynamic cardno;
  dynamic birthdate;
  bool gender;
  bool isPassive;
  dynamic isdeleted;
  bool isdisabled;
  String phone;
  int hotelid;

  Profile({
    required this.guestid,
    required this.email,
    required this.fullname,
    required this.photourl,
    required this.cardno,
    required this.birthdate,
    required this.gender,
    required this.isPassive,
    required this.isdeleted,
    required this.isdisabled,
    required this.phone,
    required this.hotelid,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        guestid: json["GUESTID"],
        email: json["EMAIL"],
        fullname: json["FULLNAME"],
        photourl: json["PHOTOURL"],
        cardno: json["CARDNO"],
        birthdate: json["BIRTHDATE"],
        gender: json["GENDER"],
        isPassive: json["IS_PASSIVE"],
        isdeleted: json["ISDELETED"],
        isdisabled: json["ISDISABLED"],
        phone: json["PHONE"],
        hotelid: json["HOTELID"],
      );

  Map<String, dynamic> toJson() => {
        "GUESTID": guestid,
        "EMAIL": email,
        "FULLNAME": fullname,
        "PHOTOURL": photourl,
        "CARDNO": cardno,
        "BIRTHDATE": birthdate,
        "GENDER": gender,
        "IS_PASSIVE": isPassive,
        "ISDELETED": isdeleted,
        "ISDISABLED": isdisabled,
        "PHONE": phone,
        "HOTELID": hotelid,
      };
}

class Program {
  int exerciseid;
  String exercisename;
  String? exercisephotourl;
  List<P> p;

  Program({
    required this.exerciseid,
    required this.exercisename,
    required this.exercisephotourl,
    required this.p,
  });

  factory Program.fromJson(Map<String, dynamic> json) => Program(
        exerciseid: json["EXERCISEID"],
        exercisename: json["EXERCISENAME"],
        exercisephotourl: json["EXERCISEPHOTOURL"],
        p: List<P>.from(json["P"].map((x) => P.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "EXERCISEID": exerciseid,
        "EXERCISENAME": exercisename,
        "EXERCISEPHOTOURL": exercisephotourl,
        "P": List<dynamic>.from(p.map((x) => x.toJson())),
      };
}

class P {
  int quantity;
  int repeatnumber;
  String? notes;
  int dayoftheweek;

  P({
    required this.quantity,
    required this.repeatnumber,
    required this.notes,
    required this.dayoftheweek,
  });

  factory P.fromJson(Map<String, dynamic> json) => P(
        quantity: json["QUANTITY"],
        repeatnumber: json["REPEATNUMBER"],
        notes: json["NOTES"],
        dayoftheweek: json["DAYOFTHEWEEK"],
      );

  Map<String, dynamic> toJson() => {
        "QUANTITY": quantity,
        "REPEATNUMBER": repeatnumber,
        "NOTES": notes,
        "DAYOFTHEWEEK": dayoftheweek,
      };
}

class SpaGroupActivityModel {
  int id;
  int hotelid;
  DateTime startTime;
  int groupactivityid;
  String name;
  bool active;
  String notes;
  int level;
  int categoriid;
  int duration;
  int trainerid;
  int placeid;
  int creatorid;
  DateTime creationDate;
  int capacity;
  String trainername;
  String placename;
  String categoriname;

  SpaGroupActivityModel({
    required this.id,
    required this.hotelid,
    required this.startTime,
    required this.groupactivityid,
    required this.name,
    required this.active,
    required this.notes,
    required this.level,
    required this.categoriid,
    required this.duration,
    required this.trainerid,
    required this.placeid,
    required this.creatorid,
    required this.creationDate,
    required this.capacity,
    required this.trainername,
    required this.placename,
    required this.categoriname,
  });

  factory SpaGroupActivityModel.fromJson(Map<String, dynamic> json) => SpaGroupActivityModel(
        id: json["ID"],
        hotelid: json["HOTELID"],
        startTime: DateTime.parse(json["START_TIME"]),
        groupactivityid: json["GROUPACTIVITYID"],
        name: json["NAME"],
        active: json["ACTIVE"],
        notes: json["NOTES"],
        level: json["LEVEL"],
        categoriid: json["CATEGORIID"],
        duration: json["DURATION"],
        trainerid: json["TRAINERID"],
        placeid: json["PLACEID"],
        creatorid: json["CREATORID"],
        creationDate: DateTime.parse(json["CREATION_DATE"]),
        capacity: json["CAPACITY"],
        trainername: json["TRAINERNAME"],
        placename: json["PLACENAME"],
        categoriname: json["CATEGORINAME"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "HOTELID": hotelid,
        "START_TIME": startTime.toIso8601String(),
        "GROUPACTIVITYID": groupactivityid,
        "NAME": name,
        "ACTIVE": active,
        "NOTES": notes,
        "LEVEL": level,
        "CATEGORIID": categoriid,
        "DURATION": duration,
        "TRAINERID": trainerid,
        "PLACEID": placeid,
        "CREATORID": creatorid,
        "CREATION_DATE": creationDate.toIso8601String(),
        "CAPACITY": capacity,
        "TRAINERNAME": trainername,
        "PLACENAME": placename,
        "CATEGORINAME": categoriname,
      };
}

class SpaGroupActivityMemberListModel {
  int id;
  int hotelid;
  int groupactivityTimetableid;
  int memberid;
  DateTime startTime;
  int groupactivityid;
  String name;
  bool active;
  String photourl;
  String notes;
  int level;
  int categoriid;
  int duration;
  int trainerid;
  int placeid;
  dynamic onlyForMembers;
  int creatorid;
  DateTime creationDate;
  int capacity;
  String trainername;
  String placename;
  String categoriname;
  String membername;

  SpaGroupActivityMemberListModel({
    required this.id,
    required this.hotelid,
    required this.groupactivityTimetableid,
    required this.memberid,
    required this.startTime,
    required this.groupactivityid,
    required this.name,
    required this.active,
    required this.photourl,
    required this.notes,
    required this.level,
    required this.categoriid,
    required this.duration,
    required this.trainerid,
    required this.placeid,
    required this.onlyForMembers,
    required this.creatorid,
    required this.creationDate,
    required this.capacity,
    required this.trainername,
    required this.placename,
    required this.categoriname,
    required this.membername,
  });

  factory SpaGroupActivityMemberListModel.fromJson(Map<String, dynamic> json) => SpaGroupActivityMemberListModel(
        id: json["ID"],
        hotelid: json["HOTELID"],
        groupactivityTimetableid: json["GROUPACTIVITY_TIMETABLEID"],
        memberid: json["MEMBERID"],
        startTime: DateTime.parse(json["START_TIME"]),
        groupactivityid: json["GROUPACTIVITYID"],
        name: json["NAME"],
        active: json["ACTIVE"],
        photourl: json["PHOTOURL"],
        notes: json["NOTES"],
        level: json["LEVEL"],
        categoriid: json["CATEGORIID"],
        duration: json["DURATION"],
        trainerid: json["TRAINERID"],
        placeid: json["PLACEID"],
        onlyForMembers: json["ONLY_FOR_MEMBERS"],
        creatorid: json["CREATORID"],
        creationDate: DateTime.parse(json["CREATION_DATE"]),
        capacity: json["CAPACITY"],
        trainername: json["TRAINERNAME"],
        placename: json["PLACENAME"],
        categoriname: json["CATEGORINAME"],
        membername: json["MEMBERNAME"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "HOTELID": hotelid,
        "GROUPACTIVITY_TIMETABLEID": groupactivityTimetableid,
        "MEMBERID": memberid,
        "START_TIME": startTime.toIso8601String(),
        "GROUPACTIVITYID": groupactivityid,
        "NAME": name,
        "ACTIVE": active,
        "PHOTOURL": photourl,
        "NOTES": notes,
        "LEVEL": level,
        "CATEGORIID": categoriid,
        "DURATION": duration,
        "TRAINERID": trainerid,
        "PLACEID": placeid,
        "ONLY_FOR_MEMBERS": onlyForMembers,
        "CREATORID": creatorid,
        "CREATION_DATE": creationDate.toIso8601String(),
        "CAPACITY": capacity,
        "TRAINERNAME": trainername,
        "PLACENAME": placename,
        "CATEGORINAME": categoriname,
        "MEMBERNAME": membername,
      };
}

class SpaMemberBodyAnalityModel {
  int id;
  int hotelid;
  int poscardid;
  int? age;
  DateTime date;
  int? weight;
  int? height;
  int? chest;
  int? arm;
  int? waist;
  int? hips;
  int? thigh;
  int? calf;
  int? totalbodywater;
  int? totalmusclemass;
  int? totalbodyfatmass;
  int? bodymassindex;
  bool isdeleted;
  int creatorid;
  DateTime creationDate;
  DateTime lastupdateDate;
  String fullname;

  SpaMemberBodyAnalityModel({
    required this.id,
    required this.hotelid,
    required this.poscardid,
    this.age,
    required this.date,
    this.weight,
    this.height,
    this.chest,
    this.arm,
    this.waist,
    this.hips,
    this.thigh,
    this.calf,
    this.totalbodywater,
    this.totalmusclemass,
    this.totalbodyfatmass,
    this.bodymassindex,
    required this.isdeleted,
    required this.creatorid,
    required this.creationDate,
    required this.lastupdateDate,
    required this.fullname,
  });

  factory SpaMemberBodyAnalityModel.fromJson(Map<String, dynamic> json) => SpaMemberBodyAnalityModel(
        id: json["ID"],
        hotelid: json["HOTELID"],
        poscardid: json["POSCARDID"],
        age: json["AGE"],
        date: DateTime.parse(json["DATE"]),
        weight: json["WEIGHT"],
        height: json["HEIGHT"],
        chest: json["CHEST"],
        arm: json["ARM"],
        waist: json["WAIST"],
        hips: json["HIPS"],
        thigh: json["THIGH"],
        calf: json["CALF"],
        totalbodywater: json["TOTALBODYWATER"],
        totalmusclemass: json["TOTALMUSCLEMASS"],
        totalbodyfatmass: json["TOTALBODYFATMASS"],
        bodymassindex: json["BODYMASSINDEX"],
        isdeleted: json["ISDELETED"],
        creatorid: json["CREATORID"],
        creationDate: DateTime.parse(json["CREATION_DATE"]),
        lastupdateDate: DateTime.parse(json["LASTUPDATE_DATE"]),
        fullname: json["FULLNAME"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "HOTELID": hotelid,
        "POSCARDID": poscardid,
        "AGE": age,
        "DATE": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "WEIGHT": weight,
        "HEIGHT": height,
        "CHEST": chest,
        "ARM": arm,
        "WAIST": waist,
        "HIPS": hips,
        "THIGH": thigh,
        "CALF": calf,
        "TOTALBODYWATER": totalbodywater,
        "TOTALMUSCLEMASS": totalmusclemass,
        "TOTALBODYFATMASS": totalbodyfatmass,
        "BODYMASSINDEX": bodymassindex,
        "ISDELETED": isdeleted,
        "CREATORID": creatorid,
        "CREATION_DATE": creationDate.toIso8601String(),
        "LASTUPDATE_DATE": lastupdateDate.toIso8601String(),
        "FULLNAME": fullname,
      };
}

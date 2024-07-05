class RequestResponse {
  String message;
  bool result;

  RequestResponse({required this.message, required this.result});
}

class MemberModel {
  Profile profile;
  List<Program> program;
  List<Membership> membership;

  MemberModel({
    required this.profile,
    required this.program,
    required this.membership,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        profile: Profile.fromJson(json["PROFILE"]),
        program: List<Program>.from(json["PROGRAM"].map((x) => Program.fromJson(x))),
        membership: List<Membership>.from(json["MEMBERSHIP"].map((x) => Membership.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "PROFILE": profile.toJson(),
        "PROGRAM": List<dynamic>.from(program.map((x) => x.toJson())),
        "MEMBERSHIP": List<dynamic>.from(membership.map((x) => x.toJson())),
      };
}

class Membership {
  DateTime startdate;
  DateTime lastdate;
  DateTime actualenddate;
  double price;
  DateTime contractdate;
  dynamic notes;
  String membershiptype;
  String currency;
  String salespersonnel;
  String membername;
  dynamic membercardno;
  String membernames;
  int extraday;
  int frozenday;

  Membership({
    required this.startdate,
    required this.lastdate,
    required this.actualenddate,
    required this.price,
    required this.contractdate,
    required this.notes,
    required this.membershiptype,
    required this.currency,
    required this.salespersonnel,
    required this.membername,
    required this.membercardno,
    required this.membernames,
    required this.extraday,
    required this.frozenday,
  });

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
        startdate: DateTime.parse(json["STARTDATE"]),
        lastdate: DateTime.parse(json["LASTDATE"]),
        actualenddate: DateTime.parse(json["ACTUALENDDATE"]),
        price: json["PRICE"],
        contractdate: DateTime.parse(json["CONTRACTDATE"]),
        notes: json["NOTES"],
        membershiptype: json["MEMBERSHIPTYPE"],
        currency: json["CURRENCY"],
        salespersonnel: json["SALESPERSONNEL"],
        membername: json["MEMBERNAME"],
        membercardno: json["MEMBERCARDNO"],
        membernames: json["MEMBERNAMES"],
        extraday: json["EXTRADAY"],
        frozenday: json["FROZENDAY"],
      );

  Map<String, dynamic> toJson() => {
        "STARTDATE": startdate.toIso8601String(),
        "LASTDATE": lastdate.toIso8601String(),
        "ACTUALENDDATE": actualenddate.toIso8601String(),
        "PRICE": price,
        "CONTRACTDATE": contractdate.toIso8601String(),
        "NOTES": notes,
        "MEMBERSHIPTYPE": membershiptype,
        "CURRENCY": currency,
        "SALESPERSONNEL": salespersonnel,
        "MEMBERNAME": membername,
        "MEMBERCARDNO": membercardno,
        "MEMBERNAMES": membernames,
        "EXTRADAY": extraday,
        "FROZENDAY": frozenday,
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
  String photoUrl;
  String notes;
  int level;
  int? categoriid;
  int duration;
  int trainerid;
  int placeid;
  int creatorid;
  DateTime creationDate;
  int capacity;
  String? trainername;
  String? placename;
  String? categoriname;

  SpaGroupActivityModel({
    required this.id,
    required this.hotelid,
    required this.startTime,
    required this.groupactivityid,
    required this.name,
    required this.active,
    required this.photoUrl,
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

  factory SpaGroupActivityModel.fromJson(Map<String, dynamic> json) {
    return SpaGroupActivityModel(
      id: json["ID"],
      hotelid: json["HOTELID"],
      startTime: json["START_TIME"] != null ? DateTime.parse(json["START_TIME"]) : DateTime.now(),
      groupactivityid: json["GROUPACTIVITYID"],
      name: json["NAME"],
      active: json["ACTIVE"],
      photoUrl: json["PHOTOURL"],
      notes: json["NOTES"] ?? "",
      level: json["LEVEL"] ?? 0,
      categoriid: json["CATEGORIID"],
      duration: json["DURATION"],
      trainerid: json["TRAINERID"],
      placeid: json["PLACEID"],
      creatorid: json["CREATORID"],
      creationDate: DateTime.parse(json["CREATION_DATE"]),
      capacity: json["CAPACITY"] ?? 0,
      trainername: json["TRAINERNAME"],
      placename: json["PLACENAME"],
      categoriname: json["CATEGORINAME"],
    );
  }
}

class SpaGroupActivityMemberListModel {
  int id;
  int hotelid;
  int groupactivityTimetableid;
  int? memberid;
  DateTime? startTime;
  int? groupactivityid;
  String? name;
  bool? active;
  String? photourl;
  String? notes;
  int? level;
  int? categoriid;
  int? duration;
  int? trainerid;
  int? placeid;
  dynamic onlyForMembers;
  int? creatorid;
  DateTime? creationDate;
  int? capacity;
  String? trainername;
  String? placename;
  String? categoriname;
  String? membername;

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
        startTime: json["START_TIME"] == null ? null : DateTime.parse(json["START_TIME"]),
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
        creationDate: json["CREATION_DATE"] == null ? null : DateTime.parse(json["CREATION_DATE"]),
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
        "START_TIME": startTime?.toIso8601String(),
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
        "CREATION_DATE": creationDate?.toIso8601String(),
        "CAPACITY": capacity,
        "TRAINERNAME": trainername,
        "PLACENAME": placename,
        "CATEGORINAME": categoriname,
        "MEMBERNAME": membername,
      };
}

class SpaMemberBodyAnalysis {
  int? id;
  int? hotelId;
  int? poscardId;
  int? age;
  String? date;
  double? weight;
  double? height;
  double? chest;
  double? arm;
  double? waist;
  double? hips;
  double? thigh;
  double? calf;
  double? totalBodyWater;
  double? totalMuscleMass;
  double? totalBodyFatMass;
  double? bodyMassIndex;
  bool? isDeleted;
  int? creatorId;
  DateTime? creationDate;
  dynamic updateUser;
  DateTime? lastUpdateDate;
  String? fullName;

  SpaMemberBodyAnalysis({
    this.id,
    this.hotelId,
    this.poscardId,
    this.age,
    this.date,
    this.weight,
    this.height,
    this.chest,
    this.arm,
    this.waist,
    this.hips,
    this.thigh,
    this.calf,
    this.totalBodyWater,
    this.totalMuscleMass,
    this.totalBodyFatMass,
    this.bodyMassIndex,
    this.isDeleted,
    this.creatorId,
    this.creationDate,
    this.updateUser,
    this.lastUpdateDate,
    this.fullName,
  });

  factory SpaMemberBodyAnalysis.fromJson(Map<String, dynamic> json) {
    return SpaMemberBodyAnalysis(
      id: json['ID'],
      hotelId: json['HOTELID'],
      poscardId: json['POSCARDID'],
      age: json['AGE'] ?? 0,
      date: json['DATE'],
      weight: json['WEIGHT']?.toDouble() ?? 0.0,
      height: json['HEIGHT']?.toDouble() ?? 0.0,
      chest: json['CHEST']?.toDouble(),
      arm: json['ARM']?.toDouble(),
      waist: json['WAIST']?.toDouble(),
      hips: json['HIPS']?.toDouble(),
      thigh: json['THIGH']?.toDouble(),
      calf: json['CALF']?.toDouble(),
      totalBodyWater: json['TOTALBODYWATER']?.toDouble(),
      totalMuscleMass: json['TOTALMUSCLEMASS']?.toDouble(),
      totalBodyFatMass: json['TOTALBODYFATMASS']?.toDouble(),
      bodyMassIndex: json['BODYMASSINDEX']?.toDouble(),
      isDeleted: json['ISDELETED'],
      creatorId: json['CREATORID'],
      creationDate: DateTime.parse(json['CREATION_DATE']),
      updateUser: json['UPDATEUSER'].toString(),
      lastUpdateDate: DateTime.parse(json['LASTUPDATE_DATE']),
      fullName: json['FULLNAME'].toString(),
    );
  }
}

class ReservationModel {
  int id;
  int hotelid;
  int? portalid;
  int? checkid;
  int depid;
  DateTime creationdate;
  DateTime? resstart;
  DateTime? resend;
  int serviceid;
  double quantity;
  double mctotal;
  int currencyid;
  double ctotal;
  bool paid;
  int? staffid;
  dynamic placeid;
  dynamic resnameid;
  int poscardid;
  dynamic notes;
  int statusid;
  int? colorid;
  dynamic dayoffreasonid;
  dynamic packageid;
  dynamic spaInhouselistid;
  String depname;
  String servicename;
  int producttypeid;
  String currencycode;
  String? staffname;
  dynamic placename;
  dynamic hotelGuestname;
  String poscardGuestname;
  String statusname;
  String? colorname;
  dynamic dayoffreason;
  dynamic hotelCheckin;
  dynamic hotelCheckout;
  dynamic hotelRoomno;
  String creatorname;
  int cancel;
  String guestname;
  double netCtotal;
  double netMctotal;
  double discountpercent;
  dynamic resnameHotelid;

  ReservationModel({
    required this.id,
    required this.hotelid,
    required this.portalid,
    required this.checkid,
    required this.depid,
    required this.creationdate,
    required this.resstart,
    required this.resend,
    required this.serviceid,
    required this.quantity,
    required this.mctotal,
    required this.currencyid,
    required this.ctotal,
    required this.paid,
    required this.staffid,
    required this.placeid,
    required this.resnameid,
    required this.poscardid,
    required this.notes,
    required this.statusid,
    required this.colorid,
    required this.dayoffreasonid,
    required this.packageid,
    required this.spaInhouselistid,
    required this.depname,
    required this.servicename,
    required this.producttypeid,
    required this.currencycode,
    required this.staffname,
    required this.placename,
    required this.hotelGuestname,
    required this.poscardGuestname,
    required this.statusname,
    required this.colorname,
    required this.dayoffreason,
    required this.hotelCheckin,
    required this.hotelCheckout,
    required this.hotelRoomno,
    required this.creatorname,
    required this.cancel,
    required this.guestname,
    required this.netCtotal,
    required this.netMctotal,
    required this.discountpercent,
    required this.resnameHotelid,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) => ReservationModel(
        id: json["ID"],
        hotelid: json["HOTELID"],
        portalid: json["PORTALID"],
        checkid: json["CHECKID"],
        depid: json["DEPID"],
        creationdate: DateTime.parse(json["CREATIONDATE"]),
        resstart: json["RESSTART"] == null ? null : DateTime.parse(json["RESSTART"]),
        resend: json["RESEND"] == null ? null : DateTime.parse(json["RESEND"]),
        serviceid: json["SERVICEID"],
        quantity: json["QUANTITY"],
        mctotal: json["MCTOTAL"]?.toDouble(),
        currencyid: json["CURRENCYID"],
        ctotal: json["CTOTAL"],
        paid: json["PAID"],
        staffid: json["STAFFID"],
        placeid: json["PLACEID"],
        resnameid: json["RESNAMEID"],
        poscardid: json["POSCARDID"],
        notes: json["NOTES"],
        statusid: json["STATUSID"],
        colorid: json["COLORID"],
        dayoffreasonid: json["DAYOFFREASONID"],
        packageid: json["PACKAGEID"],
        spaInhouselistid: json["SPA_INHOUSELISTID"],
        depname: json["DEPNAME"],
        servicename: json["SERVICENAME"],
        producttypeid: json["PRODUCTTYPEID"],
        currencycode: json["CURRENCYCODE"],
        staffname: json["STAFFNAME"],
        placename: json["PLACENAME"],
        hotelGuestname: json["HOTEL_GUESTNAME"],
        poscardGuestname: json["POSCARD_GUESTNAME"],
        statusname: json["STATUSNAME"],
        colorname: json["COLORNAME"],
        dayoffreason: json["DAYOFFREASON"],
        hotelCheckin: json["HOTEL_CHECKIN"],
        hotelCheckout: json["HOTEL_CHECKOUT"],
        hotelRoomno: json["HOTEL_ROOMNO"],
        creatorname: json["CREATORNAME"],
        cancel: json["CANCEL"],
        guestname: json["GUESTNAME"],
        netCtotal: json["NET_CTOTAL"],
        netMctotal: json["NET_MCTOTAL"]?.toDouble(),
        discountpercent: json["DISCOUNTPERCENT"],
        resnameHotelid: json["RESNAME_HOTELID"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "HOTELID": hotelid,
        "PORTALID": portalid,
        "CHECKID": checkid,
        "DEPID": depid,
        "CREATIONDATE": creationdate.toIso8601String(),
        "RESSTART": resstart?.toIso8601String(),
        "RESEND": resend?.toIso8601String(),
        "SERVICEID": serviceid,
        "QUANTITY": quantity,
        "MCTOTAL": mctotal,
        "CURRENCYID": currencyid,
        "CTOTAL": ctotal,
        "PAID": paid,
        "STAFFID": staffid,
        "PLACEID": placeid,
        "RESNAMEID": resnameid,
        "POSCARDID": poscardid,
        "NOTES": notes,
        "STATUSID": statusid,
        "COLORID": colorid,
        "DAYOFFREASONID": dayoffreasonid,
        "PACKAGEID": packageid,
        "SPA_INHOUSELISTID": spaInhouselistid,
        "DEPNAME": depname,
        "SERVICENAME": servicename,
        "PRODUCTTYPEID": producttypeid,
        "CURRENCYCODE": currencycode,
        "STAFFNAME": staffname,
        "PLACENAME": placename,
        "HOTEL_GUESTNAME": hotelGuestname,
        "POSCARD_GUESTNAME": poscardGuestname,
        "STATUSNAME": statusname,
        "COLORNAME": colorname,
        "DAYOFFREASON": dayoffreason,
        "HOTEL_CHECKIN": hotelCheckin,
        "HOTEL_CHECKOUT": hotelCheckout,
        "HOTEL_ROOMNO": hotelRoomno,
        "CREATORNAME": creatorname,
        "CANCEL": cancel,
        "GUESTNAME": guestname,
        "NET_CTOTAL": netCtotal,
        "NET_MCTOTAL": netMctotal,
        "DISCOUNTPERCENT": discountpercent,
        "RESNAME_HOTELID": resnameHotelid,
      };
}

class AvailabilityHours {
  String workHours;

  AvailabilityHours({
    required this.workHours,
  });

  factory AvailabilityHours.fromJson(Map<String, dynamic> json) => AvailabilityHours(
        workHours: json["WORK_HOURS"],
      );

  Map<String, dynamic> toJson() => {
        "WORK_HOURS": workHours,
      };
}

class SpaInfoModel {
  Hotelinfos hotelinfos;

  SpaInfoModel({
    required this.hotelinfos,
  });

  factory SpaInfoModel.fromJson(Map<String, dynamic> json) => SpaInfoModel(
        hotelinfos: Hotelinfos.fromJson(json["HOTELINFOS"]),
      );

  Map<String, dynamic> toJson() => {
        "HOTELINFOS": hotelinfos.toJson(),
      };
}

class Hotelinfos {
  int id;
  String name;
  String address;
  String email;
  String phone;
  String logourl;
  String workingDays;
  String workingHours;
  int onlineAppointmentDepartmentid;
  List<SpaService> spaServices;

  Hotelinfos({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
    required this.logourl,
    required this.workingDays,
    required this.workingHours,
    required this.onlineAppointmentDepartmentid,
    required this.spaServices,
  });

  factory Hotelinfos.fromJson(Map<String, dynamic> json) => Hotelinfos(
        id: json["ID"],
        name: json["NAME"],
        address: json["ADDRESS"],
        email: json["EMAIL"],
        phone: json["PHONE"],
        logourl: json["LOGOURL"],
        workingDays: json["WORKING_DAYS"],
        workingHours: json["WORKING_HOURS"],
        onlineAppointmentDepartmentid: json["ONLINE_APPOINTMENT_DEPARTMENTID"],
        spaServices: List<SpaService>.from(json["SPA_SERVICES"].map((x) => SpaService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "NAME": name,
        "ADDRESS": address,
        "EMAIL": email,
        "PHONE": phone,
        "LOGOURL": logourl,
        "WORKING_DAYS": workingDays,
        "WORKING_HOURS": workingHours,
        "ONLINE_APPOINTMENT_DEPARTMENTID": onlineAppointmentDepartmentid,
        "SPA_SERVICES": List<dynamic>.from(spaServices.map((x) => x.toJson())),
      };
}

class SpaService {
  int id;
  String product;
  double price;
  int currencyid;
  String currency;

  SpaService({
    required this.id,
    required this.product,
    required this.price,
    required this.currencyid,
    required this.currency,
  });

  factory SpaService.fromJson(Map<String, dynamic> json) => SpaService(
        id: json["ID"],
        product: json["PRODUCT"],
        price: json["PRICE"],
        currencyid: json["CURRENCYID"],
        currency: json["CURRENCY"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "PRODUCT": product,
        "PRICE": price,
        "CURRENCYID": currencyid,
        "CURRENCY": currency,
      };
}
//
// class SpaInfoModels {
//   String hotelinfos;
//
//   SpaInfoModels({
//     required this.hotelinfos,
//   });
//
//   factory SpaInfoModels.fromJson(Map<String, dynamic> json) => SpaInfoModels(
//         hotelinfos: json["HOTELINFOS"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "HOTELINFOS": hotelinfos,
//       };
// }

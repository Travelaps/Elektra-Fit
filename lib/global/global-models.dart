class RequestResponse {
  String message;
  bool result;

  RequestResponse({required this.message, required this.result});
}

class FitnessModal {
  Profile? profile;
  List<Program>? program;
  List<Membership>? membership;

  FitnessModal({
    this.profile,
    this.program,
    this.membership,
  });

  factory FitnessModal.fromMap(Map<String, dynamic> json) => FitnessModal(
        profile: json["PROFILE"] == null ? null : Profile.fromMap(json["PROFILE"]),
        program: json["PROGRAM"] == null ? [] : List<Program>.from(json["PROGRAM"]!.map((x) => Program.fromMap(x))),
        membership: json["MEMBERSHIP"] == null ? [] : List<Membership>.from(json["MEMBERSHIP"]!.map((x) => Membership.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "PROFILE": profile?.toMap(),
        "PROGRAM": program == null ? [] : List<dynamic>.from(program!.map((x) => x.toMap())),
        "MEMBERSHIP": membership == null ? [] : List<dynamic>.from(membership!.map((x) => x.toMap())),
      };
}

class Membership {
  DateTime? startdate;
  DateTime? lastdate;
  DateTime? actualenddate;
  double? price;
  DateTime? contractdate;
  dynamic notes;
  String? membershiptype;
  String? currency;
  String? salespersonnel;
  String? membername;
  dynamic membercardno;
  String? membernames;
  int? extraday;
  int? frozenday;

  Membership({
    this.startdate,
    this.lastdate,
    this.actualenddate,
    this.price,
    this.contractdate,
    this.notes,
    this.membershiptype,
    this.currency,
    this.salespersonnel,
    this.membername,
    this.membercardno,
    this.membernames,
    this.extraday,
    this.frozenday,
  });

  factory Membership.fromMap(Map<String, dynamic> json) => Membership(
        startdate: json["STARTDATE"] == null ? null : DateTime.parse(json["STARTDATE"]),
        lastdate: json["LASTDATE"] == null ? null : DateTime.parse(json["LASTDATE"]),
        actualenddate: json["ACTUALENDDATE"] == null ? null : DateTime.parse(json["ACTUALENDDATE"]),
        price: json["PRICE"],
        contractdate: json["CONTRACTDATE"] == null ? null : DateTime.parse(json["CONTRACTDATE"]),
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

  Map<String, dynamic> toMap() => {
        "STARTDATE": startdate?.toIso8601String(),
        "LASTDATE": lastdate?.toIso8601String(),
        "ACTUALENDDATE": actualenddate?.toIso8601String(),
        "PRICE": price,
        "CONTRACTDATE": contractdate?.toIso8601String(),
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
  String? fullname;
  dynamic photourl;
  dynamic cardno;
  dynamic birthdate;
  dynamic gender;
  bool? isPassive;
  dynamic isdeleted;
  bool? isdisabled;
  dynamic phone;

  Profile({
    this.fullname,
    this.photourl,
    this.cardno,
    this.birthdate,
    this.gender,
    this.isPassive,
    this.isdeleted,
    this.isdisabled,
    this.phone,
  });

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
        fullname: json["FULLNAME"],
        photourl: json["PHOTOURL"],
        cardno: json["CARDNO"],
        birthdate: json["BIRTHDATE"],
        gender: json["GENDER"],
        isPassive: json["IS_PASSIVE"],
        isdeleted: json["ISDELETED"],
        isdisabled: json["ISDISABLED"],
        phone: json["PHONE"],
      );

  Map<String, dynamic> toMap() => {
        "FULLNAME": fullname,
        "PHOTOURL": photourl,
        "CARDNO": cardno,
        "BIRTHDATE": birthdate,
        "GENDER": gender,
        "IS_PASSIVE": isPassive,
        "ISDELETED": isdeleted,
        "ISDISABLED": isdisabled,
        "PHONE": phone,
      };
}

class Program {
  int? exerciseid;
  String? exercisename;
  String? exercisephotourl;
  List<P>? p;

  Program({
    this.exerciseid,
    this.exercisename,
    this.exercisephotourl,
    this.p,
  });

  factory Program.fromMap(Map<String, dynamic> json) => Program(
        exerciseid: json["EXERCISEID"],
        exercisename: json["EXERCISENAME"],
        exercisephotourl: json["EXERCISEPHOTOURL"],
        p: json["P"] == null ? [] : List<P>.from(json["P"]!.map((x) => P.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "EXERCISEID": exerciseid,
        "EXERCISENAME": exercisename,
        "EXERCISEPHOTOURL": exercisephotourl,
        "P": p == null ? [] : List<dynamic>.from(p!.map((x) => x.toMap())),
      };
}

class P {
  int? quantity;
  int? repeatnumber;
  String? notes;
  int? dayoftheweek;

  P({
    this.quantity,
    this.repeatnumber,
    this.notes,
    this.dayoftheweek,
  });

  factory P.fromMap(Map<String, dynamic> json) => P(
        quantity: json["QUANTITY"],
        repeatnumber: json["REPEATNUMBER"],
        notes: json["NOTES"],
        dayoftheweek: json["DAYOFTHEWEEK"],
      );

  Map<String, dynamic> toMap() => {
        "QUANTITY": quantity,
        "REPEATNUMBER": repeatnumber,
        "NOTES": notes,
        "DAYOFTHEWEEK": dayoftheweek,
      };
}

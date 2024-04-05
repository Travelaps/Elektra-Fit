class PaymentGate {
  int id;
  String name;
  int mainbank;

  PaymentGate({
    required this.id,
    required this.name,
    required this.mainbank,
  });

  factory PaymentGate.fromJson(Map<String, dynamic> json) => PaymentGate(
        id: json["ID"],
        name: json["NAME"],
        mainbank: json["MAINBANK"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "NAME": name,
        "MAINBANK": mainbank,
      };
}

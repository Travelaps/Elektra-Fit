import 'package:elektra_fit/global/index.dart';
import 'package:elektra_fit/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../global/global-models.dart';

class ReservationCreate extends StatefulWidget {
  ReservationCreate({required this.selectedHours, required this.resStart, required this.spaService, super.key});

  SpaService spaService;
  String selectedHours;
  DateTime resStart;

  @override
  State<ReservationCreate> createState() => _ReservationCreateState();
}

class _ReservationCreateState extends State<ReservationCreate> {
  final service = GetIt.I<ProfileService>();

  TextEditingController _nameAndSurname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> reservationCreate() async {
    var validationResult = _formKey.currentState!.validate();
    if (validationResult) {
      await reservationsucces(_nameAndSurname.text, _email.text, _phone.text, widget.spaService, widget.resStart, widget.selectedHours, service.resId$.value);
      // service.reservationCreate(_nameAndSurname.text, _phone.text, widget.resStart, widget.spaService, service.paymentType$.value).then((value) {
      //   if (value!.result) {
      //     // kShowBanner(BannerType.SUCCESS, value.message, context);
      //   } else {
      //     kShowBanner(BannerType.ERROR, value.message, context);
      //   }
      // });
    } else {
      Map<String, String?> errors = {};
      if (_nameAndSurname.text.isEmpty) {
        errors['nameAndSurname'] = "Please enter your name and surname".tr();
      }
      if (_phone.text.isEmpty) {
        errors['phone'] = "Please enter your phone number".tr();
      }
      kShowBanner(BannerType.ERROR, "Please correct the following errors: ${errors.values.join(', ')}", context);
    }
  }

  Future<dynamic> reservationsucces(String email, String phone, String fullName, SpaService spaService, DateTime resStart, String selectedHours, String resId) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        final double H = MediaQuery.of(context).size.height;
        final double W = MediaQuery.of(context).size.width;

        return Container(
          height: H * 0.7,
          padding: paddingAll10,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(alignment: Alignment.center, child: Lottie.asset('assets/animations/success.json', width: W / 3, height: W / 3, fit: BoxFit.cover)),
                    SizedBox(width: W / 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Reservation Details".tr(), style: kMontserrat17),
                        Divider(),
                        StreamBuilder(
                            stream: service.resId$.stream,
                            builder: (context, snapshot) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [Text("Reservation Number".tr(), style: kProxima17), Text(service.resId$.value, style: kProxima17)],
                              );
                            }),
                        SizedBox(width: W / 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Reservation Date".tr(), style: kProxima17), Text(DateFormat("dd MMM yyyy").format(resStart), style: kProxima17)],
                        ),
                        SizedBox(width: W / 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Service Price".tr(), style: kProxima17), Text(spaService.product, style: kProxima17)],
                        ),
                        SizedBox(width: W / 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Reservation Time".tr(), style: kProxima17), Text(selectedHours, style: kProxima17)],
                        ),
                      ],
                    ),
                    SizedBox(width: W / 40),
                    Text("Guest Details".tr(), style: kMontserrat17),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Name Surname".tr()), Text(fullName, style: kProxima17)],
                    ),
                    SizedBox(width: W / 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Email".tr()), Text(email, style: kProxima17)],
                    ),
                    SizedBox(width: W / 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Phone Number".tr()), Text(phone, style: kProxima17)],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            padding: paddingAll8,
                            decoration: BoxDecoration(border: Border.all(color: config.primaryColor), borderRadius: borderRadius10),
                            child: Text("Book Again".tr(), style: kProxima18.copyWith(color: config.primaryColor))),
                      ),
                    ),
                    SizedBox(width: W / 40),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => MyOperations(),
                              ));
                        },
                        child: Container(
                            alignment: Alignment.center,
                            padding: paddingAll8,
                            decoration: BoxDecoration(border: Border.all(color: config.primaryColor), borderRadius: borderRadius10),
                            child: Text("My Reservation".tr(), style: kProxima18.copyWith(color: config.primaryColor))),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("Reservation Completion")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: GestureDetector(
            onTap: () {
              Focus.of(context).unfocus();
            },
            child: StreamBuilder(
                stream: member$.stream,
                builder: (context, snapshot) {
                  return Container(
                    padding: paddingAll10,
                    height: H * 0.84,
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: paddingAll5,
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius10, boxShadow: [
                                    BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 2, blurRadius: 3, offset: Offset(0, 7)),
                                  ]),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [Text("Service Name".tr(), style: kProxima17), Text(widget.spaService.product, style: kProxima17)]),
                                    const Divider(color: Colors.black45),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [Text("Service Price".tr(), style: kProxima17), Text("${widget.spaService.price} ${widget.spaService.currency}", style: kProxima17)]),
                                    const Divider(color: Colors.black45),
                                    IntrinsicHeight(
                                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      Expanded(
                                        child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                          Image.asset("assets/icon/calender2.png", width: W / 20, height: W / 20, fit: BoxFit.cover),
                                          SizedBox(width: W / 40),
                                          Text(DateFormat("dd MMM yyyy").format(widget.resStart), style: kProxima17)
                                        ]),
                                      ),
                                      const VerticalDivider(indent: 4, color: Colors.black, thickness: 1),
                                      if (widget.selectedHours != "")
                                        Expanded(
                                            child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                          Image.asset("assets/icon/clock2.png", width: W / 20, height: W / 20, fit: BoxFit.cover),
                                          SizedBox(width: W / 40),
                                          Text(widget.selectedHours.toString(), style: kProxima17)
                                        ]))
                                    ]))
                                  ])),
                              SizedBox(height: W / 40),
                              Text("Person Information".tr(), style: kMontserrat17),
                              SizedBox(height: W / 40),
                              CTextFormField(
                                _nameAndSurname,
                                "Name Surname".tr(),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.go,
                                onchange: (v) {
                                  member$.value?.first.profile.fullname = v;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your name and surname.'.tr();
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: W / 40),
                              CTextFormField(
                                _email,
                                "Email".tr(),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.go,
                                onchange: (v) {
                                  member$.value?.first.profile.email = v;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your email address.'.tr();
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: W / 40),
                              CTextFormField(
                                _phone,
                                "Phone Number".tr(),
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your phone number.'.tr();
                                  }
                                  return null;
                                },
                                onchange: (v) {
                                  member$.value?.first.profile.phone = v;
                                },
                                // inputFormatters: [
                                //   FilteringTextInputFormatter.digitsOnly,
                                //   LengthLimitingTextInputFormatter(10),
                                //   PhoneNumberTextInputFormatter(),
                                // ],
                              ),
                              SizedBox(height: W / 40),
                            ],
                          ),
                        ),
                        CButton(title: "Complete The Reservation".tr(), func: reservationCreate, width: W)
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

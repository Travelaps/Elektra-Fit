import 'package:elektra_fit/global/index.dart';
import 'package:elektra_fit/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../global/global-models.dart';

class ReservationCreate extends StatefulWidget {
  ReservationCreate({required this.selectedHours, required this.resStart, required this.spaService, super.key});

  SpaService spaService;
  String selectedHours;
  DateTime resStart;

  @override
  State<ReservationCreate> createState() => _ReservationCreateState();
}

class _ReservationCreateState extends State<ReservationCreate> {
  final service = GetIt.I<MyOperationsService>();

  final TextEditingController _nameAndSurname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> reservationCreate() async {
    var validationResult = _formKey.currentState!.validate();
    if (validationResult) {
      service.reservationCreate(_nameAndSurname.text, _phone.text, widget.resStart, widget.spaService, service.paymentType$.value).then((value) {
        if (value!.result) {
          reservationSuccesfullWidget(
              _email.text, _phone.text, _nameAndSurname.text, widget.spaService, widget.resStart, widget.selectedHours, service.resId$.value);
        } else {
          kShowBanner(BannerType.ERROR, value.message, context);
        }
      });
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

  @override
  void initState() {
    _phone.text = "";
    _nameAndSurname.text = "";
    _email.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(title: Text("Reservation Summary".tr())),
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Container(
                      padding: paddingAll10,
                      height: H * 0.89,
                      child: Column(children: [
                        Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("Service Information".tr(), style: kMontserrat17),
                          const Divider(color: Colors.black45),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Service Name".tr(), style: kProxima17), Text(widget.spaService.product, style: kProxima17)]),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text("Service Price".tr(), style: kProxima17),
                            Text("${widget.spaService.price} ${widget.spaService.currency}", style: kProxima17)
                          ]),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text("Reservation Date".tr(), style: kProxima17),
                            Text(DateFormat("dd MMM yyyy").format(widget.resStart), style: kProxima17)
                          ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Reservation Time".tr(), style: kProxima17), Text(widget.selectedHours.toString(), style: kProxima17)]),
                          SizedBox(height: W / 30),
                          Text("Person Information".tr(), style: kMontserrat17),
                          const Divider(color: Colors.black45),
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
                          CTextFormField(_email, "Email".tr(), keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.go,
                              onchange: (v) {
                            member$.value?.first.profile.email = v;
                          }, validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your email address.'.tr();
                            }
                            return null;
                          }),
                          SizedBox(height: W / 40),
                          CTextFormField(_phone, "Phone Number".tr(), keyboardType: TextInputType.phone, textInputAction: TextInputAction.done,
                              validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your phone number.'.tr();
                            }
                            return null;
                          }, onchange: (v) {
                            member$.value?.first.profile.phone = v;
                          }),
                          SizedBox(height: W / 40)
                        ]),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                          child: CButton(title: "Complete The Reservation".tr(), func: reservationCreate, width: W),
                        )
                      ]))),
            )));
  }

  Future<dynamic> reservationSuccesfullWidget(
      String email, String phone, String fullName, SpaService spaService, DateTime resStart, String selectedHours, int resId) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final double H = MediaQuery.of(context).size.height;
        final double W = MediaQuery.of(context).size.width;
        return StreamBuilder(
            stream: isLoading$.stream,
            builder: (context, snapshot) {
              return Container(
                  alignment: Alignment.bottomRight,
                  height: H * 0.6,
                  padding: paddingAll10,
                  child: isLoading$.value
                      ? Center(child: CircularProgressIndicator(color: config.primaryColor))
                      : Column(children: [
                          Container(
                              alignment: Alignment.center,
                              child: Lottie.asset('assets/animations/success.json', width: W / 3, height: W / 3, fit: BoxFit.cover)),
                          SizedBox(width: W / 40),
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("Reservation Details".tr(), style: kMontserrat17),
                            const Divider(),
                            StreamBuilder(
                                stream: service.resId$.stream,
                                builder: (context, snapshot) {
                                  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    Text("Reservation Number".tr(), style: kProxima17),
                                    Text(service.resId$.value.toString(), style: kProxima17)
                                  ]);
                                }),
                            SizedBox(width: W / 60),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text("Reservation Date".tr(), style: kProxima17),
                              Text(DateFormat("dd MMM yyyy").format(resStart), style: kProxima17)
                            ]),
                            SizedBox(width: W / 60),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Service Price".tr(), style: kProxima17), Text(spaService.product, style: kProxima17)],
                            ),
                            SizedBox(width: W / 60),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Reservation Time".tr(), style: kProxima17), Text(selectedHours, style: kProxima17)],
                            )
                          ]),
                          SizedBox(width: W / 40),
                          Container(alignment: Alignment.bottomLeft, child: Text("Guest Details".tr(), style: kMontserrat17)),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("Name Surname".tr(), style: kProxima17), Text(fullName, style: kProxima17)],
                          ),
                          SizedBox(width: W / 60),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("Email".tr(), style: kProxima17), Text(email, style: kProxima17)],
                          ),
                          SizedBox(width: W / 60),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Phone Number".tr(), style: kProxima17), Text(phone, style: kProxima17)]),
                          const Divider(),
                          Padding(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Expanded(
                                    child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, RouteAnimation.createRoute(MyOperationDetail(), 1, 0));
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: paddingAll8,
                                      decoration: BoxDecoration(border: Border.all(color: config.primaryColor), borderRadius: borderRadius10),
                                      child: Text("Book Again".tr(), style: kProxima18.copyWith(color: config.primaryColor))),
                                )),
                                SizedBox(width: W / 40),
                                Expanded(
                                    child: InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation, secondaryAnimation) => const MyOperations(),
                                        ));
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: paddingAll8,
                                      decoration: BoxDecoration(border: Border.all(color: config.primaryColor), borderRadius: borderRadius10),
                                      child: Text("My Reservations".tr(), style: kProxima18.copyWith(color: config.primaryColor))),
                                )),
                              ]))
                        ]));
            });
      },
    );
  }
}

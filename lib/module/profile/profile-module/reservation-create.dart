import 'package:elektra_fit/global/index.dart';
import 'package:elektra_fit/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      service.reservationCreate(_nameAndSurname.text, _phone.text, widget.resStart, widget.spaService, service.paymentType$.value).then((value) {
        if (value!.result) {
          kShowBanner(BannerType.SUCCESS, value.message, context);
        } else {
          kShowBanner(BannerType.ERROR, value.message, context);
        }
      });
    } else {
      Map<String, String?> errors = {};
      if (_nameAndSurname.text.isEmpty) {
        errors['nameAndSurname'] = "Please enter your name and surname";
      }
      if (_phone.text.isEmpty) {
        errors['phone'] = "Please enter your phone number";
      }
      kShowBanner(BannerType.ERROR, "Please correct the following errors: ${errors.values.join(', ')}", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text(widget.spaService.product)),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: GestureDetector(
            onTap: () {
              Focus.of(context).unfocus();
            },
            child: StreamBuilder(
                stream: service.paymentType$.stream,
                builder: (context, snapshot) {
                  return Container(
                    padding: paddingAll10,
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.spaService.product, style: kProxima17),
                                Text("${widget.spaService.price.toStringAsFixed(1)} ${widget.spaService.currency}", style: kProxima17),
                              ],
                            ),
                            Divider(),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Row(
                                children: [
                                  Image.asset("assets/icon/calender2.png", width: W / 15, height: W / 15, fit: BoxFit.cover),
                                  SizedBox(width: W / 40),
                                  Text(DateFormat("dd MMM yyyy").format(widget.resStart), style: kProxima17),
                                ],
                              ),
                              if (widget.selectedHours != "")
                                Row(children: [
                                  Image.asset("assets/icon/clock2.png", width: W / 15, height: W / 15, fit: BoxFit.cover),
                                  SizedBox(width: W / 40),
                                  Text(widget.selectedHours.toString(), style: kProxima17)
                                ])
                            ]),
                            SizedBox(height: W / 10),
                            Text("Person Information :".tr(), style: kMontserrat17),
                            SizedBox(height: W / 40),
                            CTextFormField(
                              _nameAndSurname,
                              "Name Surname".tr(),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.go,
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
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                                PhoneNumberTextInputFormatter(),
                              ],
                            ),
                            SizedBox(height: W / 40),
                          ],
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

import 'package:elektra_fit/global/index.dart';
import 'package:elektra_fit/widget/index.dart';
import 'package:flutter/material.dart';

import '../../../global/global-models.dart';

class ReservationCreate extends StatefulWidget {
  ReservationCreate({required this.spaService, super.key});

  SpaService spaService;

  @override
  State<ReservationCreate> createState() => _ReservationCreateState();
}

class _ReservationCreateState extends State<ReservationCreate> {
  final service = GetIt.I<ProfileService>();

  TextEditingController _nameAndSurname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text(widget.spaService.product)),
      body: SingleChildScrollView(
        child: Container(
          height: H * 0.84,
          padding: paddingAll10,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CTextFormField(
                      _nameAndSurname,
                      "Name Surname".tr(),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.go,
                    ),
                    SizedBox(height: W / 40),
                    CTextFormField(
                      _email,
                      "Email".tr(),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.go,
                    ),
                    SizedBox(height: W / 40),
                    CTextFormField(_phone, "Phone".tr(), keyboardType: TextInputType.phone, textInputAction: TextInputAction.done, validator: (value) {
                      _phone.text = value;
                    }),
                    SizedBox(height: W / 40)
                  ],
                ),
              ),
              CButton(
                title: "Reservation Create".tr(),
                func: () {},
                width: W,
              )
            ],
          ),
        ),
      ),
    );
  }
}

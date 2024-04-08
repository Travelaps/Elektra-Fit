import 'package:elektra_fit/global/index.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../global/global-models.dart';

class ReservationCompletion extends StatefulWidget {
  const ReservationCompletion({
    Key? key,
    required this.nameAndSurname,
    required this.phone,
    required this.email,
    required this.startDateTime,
    required this.spaService,
    required this.selectedHours,
    required this.selectedService,
  }) : super(key: key);

  final String nameAndSurname;
  final String phone;
  final String email;
  final DateTime startDateTime;
  final SpaService spaService;
  final String selectedService;
  final String selectedHours;

  @override
  State<ReservationCompletion> createState() => _ReservationCompletionState();
}

class _ReservationCompletionState extends State<ReservationCompletion> {
  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: paddingAll10,
          child: Column(
            children: [
              Lottie.asset('assets/animations/success.json', width: W / 3, height: W / 3, fit: BoxFit.cover),
              SizedBox(width: W / 40),
              Column(
                children: [
                  Text("Reservation Details", style: kMontserrat17),
                  SizedBox(width: W / 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Reservation Number".tr()), Expanded(child: Text("numberer", style: kProxima17))],
                  ),
                  SizedBox(width: W / 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Reservation Date".tr()), Expanded(child: Text("${DateFormat("dd MMM yyyy").format(widget.startDateTime)}", style: kProxima17))],
                  ),
                  SizedBox(width: W / 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Service".tr()), Expanded(child: Text(widget.selectedService, style: kProxima17))],
                  ),
                  SizedBox(width: W / 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Reservation Time".tr()), Expanded(child: Text(widget.selectedHours, style: kProxima17))],
                  ),
                ],
              ),
              SizedBox(width: W / 40),
              Column(
                children: [
                  Text("Guest Information", style: kMontserrat17),
                  SizedBox(width: W / 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Name and Surname"), Expanded(child: Text(widget.nameAndSurname, style: kProxima17))],
                  ),
                  SizedBox(width: W / 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Email"), Expanded(child: Text(widget.email, style: kProxima17))],
                  ),
                  SizedBox(width: W / 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Phone"), Expanded(child: Text(widget.phone, style: kProxima17))],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

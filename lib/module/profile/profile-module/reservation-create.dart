import 'package:elektra_fit/global/index.dart';
import 'package:elektra_fit/widget/index.dart';
import 'package:flutter/material.dart';

import '../../../global/global-models.dart';

class ReservationCreate extends StatefulWidget {
  ReservationCreate({required this.selectedHours, required this.resStart, required this.spaService, super.key});

  SpaService spaService;
  DateTime resStart;
  String selectedHours;

  @override
  State<ReservationCreate> createState() => _ReservationCreateState();
}

class _ReservationCreateState extends State<ReservationCreate> {
  final service = GetIt.I<ProfileService>();
  final paymentService = GetIt.I<PaymentService>();

  TextEditingController _nameAndSurname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController cardName = TextEditingController();
  TextEditingController cardNo = TextEditingController();
  TextEditingController cardCvc = TextEditingController();
  BehaviorSubject<int> selectedMonth$ = BehaviorSubject.seeded(DateTime.now().month);
  BehaviorSubject<int> selectedYear$ = BehaviorSubject.seeded(DateTime.now().year);
  List<int> months = List.generate(12, (index) => index + 1);
  List<int> years = List.generate(20, (index) => DateTime.now().year + index);

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text(widget.spaService.product)),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            Focus.of(context).unfocus();
          },
          child: StreamBuilder(
              stream: service.paymentType$.stream,
              builder: (context, snapshot) {
                return Container(
                  height: H * 0.94,
                  padding: paddingAll10,
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                              ],
                            ),
                            SizedBox(height: W / 40),
                            Text("Person Information :".tr(), style: kMontserrat17),
                            SizedBox(height: W / 40),
                            CTextFormField(_nameAndSurname, "Name Surname".tr(), keyboardType: TextInputType.text, textInputAction: TextInputAction.go),
                            SizedBox(height: W / 40),
                            CTextFormField(_email, "Email".tr(), keyboardType: TextInputType.text, textInputAction: TextInputAction.go),
                            SizedBox(height: W / 40),
                            CTextFormField(_phone, "Phone Number".tr(), keyboardType: TextInputType.phone, textInputAction: TextInputAction.done, validator: (value) {
                              _phone.text = value;
                            }),
                            SizedBox(height: W / 40),
                            Text("Payment Type :", style: kMontserrat17),
                            SizedBox(height: W / 40),
                            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                              GestureDetector(
                                  onTap: () {
                                    service.paymentType$.add(1);
                                  },
                                  child: Row(children: [
                                    Image.asset("assets/icon/creadit-card.png", width: W / 15, height: W / 15, fit: BoxFit.cover),
                                    Radio<int>(
                                      value: 1,
                                      activeColor: config.primaryColor,
                                      groupValue: service.paymentType$.value,
                                      onChanged: (value) {
                                        service.paymentType$.add(value!);
                                      },
                                    ),
                                    Text('Online Payment'.tr(), style: kProxima17)
                                  ])),
                              GestureDetector(
                                  onTap: () {
                                    service.paymentType$.add(0);
                                  },
                                  child: Row(children: [
                                    Image.asset("assets/icon/cash-icon.png", width: W / 15, height: W / 15, fit: BoxFit.cover),
                                    Radio<int>(
                                      value: 0,
                                      activeColor: config.primaryColor,
                                      groupValue: service.paymentType$.value,
                                      onChanged: (value) {
                                        service.paymentType$.add(value!);
                                      },
                                    ),
                                    Text('Cash on Delivery'.tr(), style: kProxima17)
                                  ]))
                            ]),
                            SizedBox(height: W / 40),
                            if (service.paymentType$.value == 1)
                              Column(
                                children: [
                                  CTextFormField(
                                    cardName,
                                    "Card Name Surname".tr(),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.go,
                                    validator: (value) {
                                      cardName.text = value;
                                    },
                                  ),
                                  SizedBox(height: W / 40),
                                  CTextFormField(
                                    cardNo,
                                    "Card No".tr(),
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.go,
                                    validator: (value) {
                                      cardNo.text = value;
                                    },
                                  ),
                                  SizedBox(height: W / 40),
                                  Row(children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black38)),
                                        child: StreamBuilder(
                                            stream: selectedMonth$.stream,
                                            builder: (context, snapshot) {
                                              return DropdownButton(
                                                underline: SizedBox(),
                                                value: selectedMonth$.value,
                                                isExpanded: true,
                                                style: TextStyle(color: Colors.red),
                                                icon: Icon(Icons.arrow_drop_down),
                                                items: months.map((val) {
                                                  return DropdownMenuItem(
                                                      value: val,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(
                                                          "${val}".padLeft(2, '0'),
                                                          style: TextStyle(color: Colors.black),
                                                        ),
                                                      ));
                                                }).toList(),
                                                onChanged: (value) {
                                                  selectedMonth$.add(value!);
                                                },
                                              );
                                            }),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black38)),
                                        child: StreamBuilder(
                                            stream: selectedYear$.stream,
                                            builder: (context, snapshot) {
                                              return DropdownButton(
                                                underline: SizedBox(),
                                                value: selectedYear$.value,
                                                isExpanded: true,
                                                style: TextStyle(color: Colors.black),
                                                icon: Icon(Icons.arrow_drop_down),
                                                items: years.map((val) {
                                                  return DropdownMenuItem(
                                                      value: val,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(
                                                          "${val}",
                                                          style: TextStyle(color: Colors.black),
                                                        ),
                                                      ));
                                                }).toList(),
                                                onChanged: (value) {
                                                  selectedYear$.add(value!);
                                                },
                                              );
                                            }),
                                      ),
                                    ),
                                  ]),
                                  SizedBox(height: W / 40),
                                  CTextFormField(
                                    cardCvc,
                                    "Cvc Code".tr(),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      cardCvc.text = value;
                                    },
                                  ),
                                ],
                              )
                          ],
                        ),
                      ),
                      CButton(
                        title: "Complete The Reservation".tr(),
                        func: () {
                          paymentService.getPaymentGateOfBinNumber(cardNo.text).then((value) {
                            if (paymentService.paymentGate$.value?.first?.id != null) {
                              paymentService.getInstallment(false, paymentService.paymentGate$.value!.first!.id).then((value) {});
                            }
                          });

                          // if (service.paymentType$.value == 1) {
                          //   paymentService.paymentSend(cardName.text, cardNo.text, cardCvc.text, selectedMonth$.value, selectedMonth$.value)?.then((value) {
                          //     if (value.result) {
                          //       service.reservationCreate(_nameAndSurname.text, _phone.text, widget.resStart, widget.spaService, service.paymentType$.value).then((value) {
                          //         if (value!.result) {
                          //           kShowBanner(BannerType.SUCCESS, value.message, context);
                          //         }
                          //         kShowBanner(BannerType.ERROR, value.message, context);
                          //       });
                          //     }
                          //     kShowBanner(BannerType.ERROR, value.message, context);
                          //   });
                          // }
                          // service.reservationCreate(_nameAndSurname.text, _phone.text, widget.resStart, widget.spaService, service.paymentType$.value).then((value) {
                          //   if (value!.result) {
                          //     kShowBanner(BannerType.SUCCESS, value.message, context);
                          //   }
                          //   kShowBanner(BannerType.ERROR, value.message, context);
                          // });
                        },
                        width: W,
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

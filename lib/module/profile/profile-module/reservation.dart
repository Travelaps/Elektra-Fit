import 'package:elektra_fit/global/global-models.dart';
import 'package:elektra_fit/global/index.dart';
import 'package:elektra_fit/widget/index.dart';
import 'package:flutter/material.dart';

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  final service = GetIt.I<ProfileService>();
  BehaviorSubject<String> selectedHours$ = BehaviorSubject.seeded("");

  @override
  void initState() {
    service.spaInfo();
    super.initState();
  }

  @override
  void dispose() {
    service.selectDateAvailability$.add(null);
    service.spaService$.add(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(title: Text("Spa Booking".tr())),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                  stream: service.selectDateAvailability$.stream,
                  builder: (context, snapshot) {
                    return InkWell(
                        onTap: () {
                          // if (service.selectDateAvailability$.value != null) {
                          //   service.availability(service.selectDateAvailability$.value!);
                          // }
                          _selectDate(context);
                        },
                        child: Container(
                            padding: paddingAll10,
                            margin: marginAll5,
                            decoration: BoxDecoration(border: Border.all(color: config.primaryColor), borderRadius: borderRadius10),
                            child: Row(children: [
                              Icon(Icons.date_range_outlined, size: W / 15, color: config.primaryColor),
                              SizedBox(width: W / 4.2),
                              Text(
                                  service.selectDateAvailability$.value == null
                                      ? "Please choose the date".tr()
                                      : DateFormat("dd MMMM yyyy").format(
                                          service.selectDateAvailability$.value!,
                                        ),
                                  style: kAxiforma18.copyWith(color: config.primaryColor))
                            ])));
                  }),
              StreamBuilder(
                stream: service.spaService$,
                builder: (context, snapshot) {
                  if (service.spaService$.value == null) {
                    return Center(
                      child: CircularProgressIndicator(color: config.primaryColor),
                    );
                  } else if (service.spaService$.value!.isEmpty) {
                    return Center(child: Text("no found", style: kProxima17));
                  }
                  return SizedBox(
                    height: H * 0.78,
                    child: ListView.builder(
                      itemCount: service.spaService$.value?.length,
                      itemBuilder: (context, index) {
                        var item = service.spaService$.value?[index];
                        return Container(
                          alignment: Alignment.center,
                          padding: paddingAll10,
                          margin: marginAll5,
                          decoration: BoxDecoration(borderRadius: borderRadius10, color: Colors.white, boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.5), spreadRadius: 1, blurRadius: 4, offset: const Offset(0, 3)),
                          ]),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${item?.product}", style: kAxiforma17),
                                  Text("${item?.price.toStringAsFixed(2)} ${item?.currency}", style: kProxima18),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  if (service.selectDateAvailability$.value != null) {
                                    selectedHours(context, W, item);
                                  } else {
                                    kShowBanner(BannerType.ERROR, "Please select the date time".tr(), context);
                                  }
                                },
                                child: Container(
                                    padding: paddingAll8,
                                    decoration: BoxDecoration(border: Border.all(color: config.primaryColor), borderRadius: borderRadius10),
                                    child: Text("Choose".tr(), style: kProxima18.copyWith(color: config.primaryColor))),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }

  Future<dynamic> selectedHours(BuildContext context, double W, SpaService? item) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        final double H = MediaQuery.of(context).size.height;
        return SizedBox(
          height: H * 0.5,
          child: StreamBuilder(
              stream: service.availabilityHours$.stream,
              builder: (context, snapshot) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        padding: paddingAll10,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text("Select your reservation time".tr(), style: kMontserrat18),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.cancel, color: Colors.red, size: W / 12))
                        ])),
                    Expanded(
                      child: StreamBuilder(
                          stream: Rx.combineLatest2(service.availabilityHours$, selectedHours$, (a, b) => null),
                          builder: (context, snapshot) {
                            if (service.availabilityHours$.value == null) {
                              return Center(child: CircularProgressIndicator(color: config.primaryColor));
                            } else if (service.availabilityHours$.value!.isEmpty) {
                              return const Center(child: Text("no found"));
                            }
                            return Wrap(
                                spacing: 15,
                                children: service.availabilityHours$.value!.map((e) {
                                  bool selected = selectedHours$.value == e?.workHours;
                                  return InkWell(
                                      onTap: () {
                                        selectedHours$.add(e!.workHours);
                                      },
                                      child: Container(
                                        padding: paddingAll10,
                                        margin: marginAll5,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: selected ? config.primaryColor : Colors.black, width: selected ? 3 : 1),
                                            borderRadius: borderRadius10,
                                            color: selected ? config.primaryColor.withOpacity(0.3) : Colors.transparent),
                                        child: Text("${e?.workHours}", style: kProxima18),
                                      ));
                                }).toList());
                          }),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom, left: 10, right: 10),
                      child: CButton(
                          title: "Continue".tr(),
                          func: () {
                            if (selectedHours$.value != "") {
                              Navigator.push(context,
                                  RouteAnimation.createRoute(ReservationCreate(spaService: item!, resStart: service.selectDateAvailability$.value!, selectedHours: selectedHours$.value), 1, 0));
                            } else {
                              kShowBanner(BannerType.ERROR, "Please select the seans time".tr(), context);
                            }
                          },
                          width: W),
                    )
                  ],
                );
              }),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(background: Colors.white, primary: config.primaryColor, onPrimary: Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      service.selectDateAvailability$.add(picked);
      service.availability(service.selectDateAvailability$.value!);
    }
  }
}

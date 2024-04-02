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
    service.availability(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(title: Text("Booking".tr())),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                  stream: service.selectDateAvailability$.stream,
                  builder: (context, snapshot) {
                    return InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                            padding: paddingAll10,
                            margin: marginAll5,
                            decoration: BoxDecoration(border: borderAll, borderRadius: borderRadius10),
                            child: Row(children: [
                              Icon(Icons.date_range_outlined, size: W / 15),
                              SizedBox(width: W / 4),
                              Text(service.selectDateAvailability$.value == null ? "No date selected" : DateFormat("dd MMM yyyy").format(service.selectDateAvailability$.value!), style: kProxima18),
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
                          padding: paddingAll5,
                          margin: marginAll5,
                          decoration: BoxDecoration(
                            borderRadius: borderRadius10,
                            border: borderAll,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${item?.product}", style: kMontserrat17),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text("${item?.price.toStringAsFixed(2)} ${item?.currency}", style: kProxima17)),
                                  CButton(
                                    title: "Choose".tr(),
                                    func: () {
                                      if (service.selectDateAvailability$.value != null) {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              height: H * 0.6,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      padding: paddingAll10,
                                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                        Text("Select Time".tr(), style: kMontserrat17),
                                                        InkWell(
                                                            onTap: () {
                                                              Navigator.pop(context);
                                                            },
                                                            child: Icon(Icons.cancel, color: Colors.red, size: W / 14))
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
                                                          return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                            Wrap(
                                                              crossAxisAlignment: WrapCrossAlignment.start,
                                                              runAlignment: WrapAlignment.spaceBetween,
                                                              alignment: WrapAlignment.start,
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
                                                              }).toList(),
                                                            )
                                                          ]);
                                                        }),
                                                  ),
                                                  Container(
                                                    padding: paddingAll10,
                                                    margin: marginAll10,
                                                    child: CButton(
                                                        title: "Continue".tr(),
                                                        func: () {
                                                          if (selectedHours$.value != "") {
                                                            Navigator.push(
                                                                context,
                                                                RouteAnimation.createRoute(
                                                                    ReservationCreate(spaService: item!, resStart: service.selectDateAvailability$.value!, selectedHours: selectedHours$.value), 1, 0));
                                                          } else {
                                                            kShowBanner(BannerType.ERROR, "Please select the seans time".tr(), context);
                                                          }
                                                        },
                                                        width: W),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        kShowBanner(BannerType.ERROR, "Please select the date time", context);
                                      }
                                    },
                                  )
                                ],
                              ),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (picked != null) {
      service.selectDateAvailability$.add(picked);
    }
  }
}

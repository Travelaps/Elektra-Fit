import 'package:elektra_fit/global/global-models.dart';
import 'package:elektra_fit/global/index.dart';
import 'package:flutter/material.dart';

import '../../widget/index.dart';

class MyOperations extends StatefulWidget {
  const MyOperations({super.key});

  @override
  State<MyOperations> createState() => _MyOperationsState();
}

class _MyOperationsState extends State<MyOperations> {
  final service = GetIt.I<MyOperationsService>();
  late double H;
  late double W;

  @override
  void initState() {
    super.initState();
    service.spaInfo();
  }

  @override
  void dispose() {
    service.selectDateAvailability$.add(null);
    service.spaService$.add(null);
    super.dispose();
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    service.spaService$.add(null);
    service.availabilityHours$.add(null);
    service.selectedHours$.add("");
  }

  @override
  Widget build(BuildContext context) {
    H = MediaQuery.of(context).size.height;
    W = MediaQuery.of(context).size.width;
    return Scaffold(
        body: DefaultTabController(
            animationDuration: Durations.extralong1,
            length: 2,
            initialIndex: 0,
            key: UniqueKey(),
            child: Scaffold(
                appBar: AppBar(
                    title: Text("Spa Booking".tr()),
                    bottom: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: Colors.white,
                        indicatorPadding: paddingAll10,
                        isScrollable: false,
                        labelPadding: paddingAll5,
                        tabs: [
                          Tab(child: Text("New".tr(), style: kMontserrat18.copyWith(color: Colors.white))),
                          Tab(child: Text("My Appointments".tr(), style: kMontserrat18.copyWith(color: Colors.white))),
                        ])),
                body: const TabBarView(
                  children: [
                    NewSpaBooking(),
                    LastSpaMemberBookings(),
                  ],
                ))));
  }
}

class NewSpaBooking extends StatefulWidget {
  const NewSpaBooking({super.key});

  @override
  State<NewSpaBooking> createState() => _NewSpaBookingState();
}

class _NewSpaBookingState extends State<NewSpaBooking> {
  final service = GetIt.I<MyOperationsService>();
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (BuildContext context, Widget? child) {
        return Theme(
            data: ThemeData.light()
                .copyWith(colorScheme: ColorScheme.light(background: Colors.white, primary: config.primaryColor, onPrimary: Colors.white)),
            child: child!);
      },
    );
    if (picked != null) {
      service.selectDateAvailability$.add(picked);
      service.availability(picked);
    }
  }

  Future<dynamic> selectedHours(BuildContext context, double W, SpaService? item, double H) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              padding: paddingAll5,
              height: H * 0.7,
              width: W,
              child: StreamBuilder(
                  stream: service.availabilityHours$.stream,
                  builder: (context, snapshot) {
                    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text("Select Your Reservation Time".tr(), style: kMontserrat18),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.cancel, color: Colors.red, size: W / 12),
                            )
                          ])),
                      Expanded(
                          child: StreamBuilder(
                              stream: Rx.combineLatest2(service.availabilityHours$, service.selectedHours$, (a, b) => null),
                              builder: (context, snapshot) {
                                if (service.availabilityHours$.value == null) {
                                  return Center(child: CircularProgressIndicator(color: config.primaryColor));
                                } else if (service.availabilityHours$.value!.isEmpty) {
                                  return const Center(child: Text("no found"));
                                }
                                return GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                                    itemCount: service.availabilityHours$.value!.length,
                                    itemBuilder: (context, index) {
                                      var e = service.availabilityHours$.value![index];
                                      bool selected = service.selectedHours$.value == e?.workHours;
                                      return InkWell(
                                          onTap: () {
                                            service.selectedHours$.add(e!.workHours);
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(10),
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: selected ? config.primaryColor : Colors.black, width: selected ? 3 : 1),
                                                borderRadius: BorderRadius.circular(10),
                                                color: selected ? config.primaryColor.withOpacity(0.3) : Colors.transparent,
                                              ),
                                              child: Center(child: Text("${e?.workHours}", style: kProxima18))));
                                    });
                              })),
                      Container(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom, left: 10, right: 10),
                          child: CButton(
                              title: "Continue".tr(),
                              func: () {
                                if (service.selectedHours$.value != "") {
                                  Navigator.push(
                                      context,
                                      RouteAnimation.createRoute(
                                          ReservationCreate(
                                            spaService: item!,
                                            resStart: service.selectDateAvailability$.value!,
                                            selectedHours: service.selectedHours$.value,
                                          ),
                                          1,
                                          0));
                                } else {
                                  kShowBanner(BannerType.ERROR, "Please select the seans time".tr(), context);
                                }
                              },
                              width: W))
                    ]);
                  }));
        });
  }

  @override
  Widget build(BuildContext context) {
    double H = MediaQuery.of(context).size.height;
    double W = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: Column(children: [
      InkWell(
          onTap: () => selectDate(context),
          child: Container(
              padding: paddingAll10,
              margin: marginAll5,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                Icon(Icons.date_range_outlined, size: W / 15, color: config.primaryColor),
                service.selectDateAvailability$.value == null ? SizedBox(width: W / 7) : SizedBox(width: W / 4),
                Text(
                  service.selectDateAvailability$.value == null
                      ? "Please choose the date".tr()
                      : DateFormat("dd MMMM yyyy").format(service.selectDateAvailability$.value!),
                  style: kAxiforma18.copyWith(color: config.primaryColor),
                )
              ]))),
      StreamBuilder(
          stream: service.spaService$,
          builder: (context, snapshot) {
            if (service.spaService$.value == null) {
              return Center(child: CircularProgressIndicator(color: config.primaryColor));
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
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
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
                                      selectedHours(context, W, item, H);
                                    } else {
                                      kShowBanner(BannerType.ERROR, "Please select the date".tr(), context);
                                    }
                                  },
                                  child: Container(
                                    padding: paddingAll5,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: config.primaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text("Choose".tr(), style: kProxima18.copyWith(color: config.primaryColor)),
                                  ))
                            ],
                          ));
                    }));
          })
    ]));
  }
}

class LastSpaMemberBookings extends StatefulWidget {
  const LastSpaMemberBookings({super.key});

  @override
  State<LastSpaMemberBookings> createState() => _LastSpaMemberBookingsState();
}

class _LastSpaMemberBookingsState extends State<LastSpaMemberBookings> {
  final service = GetIt.I<MyOperationsService>();

  @override
  void initState() {
    service.lastSpaBooking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double H = MediaQuery.of(context).size.height;
    double W = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: service.res$.stream,
        builder: (context, snapshot) {
          if (service.res$.value == null) {
            return Center(child: CircularProgressIndicator(color: config.primaryColor));
          }
          return DefaultTabController(
              length: service.res$.value!.length,
              child: Column(
                children: [
                  TabBar(
                      isScrollable: false,
                      indicatorColor: config.primaryColor,
                      unselectedLabelStyle: kMontserrat18,
                      labelPadding: paddingAll5,
                      splashBorderRadius: BorderRadius.circular(10),
                      labelStyle: kMontserrat18.copyWith(color: config.primaryColor),
                      tabs: service.res$.value!.keys.map((e) {
                        return Tab(text: e);
                      }).toList()),
                  Expanded(
                      child: TabBarView(
                          children: service.res$.value!.keys.map((res) {
                    var item = service.res$.value?[res];
                    return item!.isEmpty
                        ? Center(
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text(res, style: kProxima17),
                            SizedBox(width: W / 70),
                            Text("reservation was not found".tr(), style: kProxima17),
                          ]))
                        : SizedBox(
                            height: H * 0.9,
                            width: W,
                            child: ListView.builder(
                                itemCount: item.length,
                                itemBuilder: (context, index) {
                                  var resItem = item[index];
                                  return Container(
                                      margin: marginAll10,
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius10, boxShadow: [
                                        BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 2, blurRadius: 5, offset: Offset(0, 7)),
                                      ]),
                                      child: Column(
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                  color: res == 'Completed'.tr() ? config.primaryColor : Colors.green),
                                              padding: paddingAll8,
                                              child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(res.tr(), style: kMontserrat17.copyWith(color: Colors.white), textAlign: TextAlign.center),
                                                  ])),
                                          Container(
                                            padding: paddingAll10,
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                              if (resItem.servicename != "")
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [Expanded(child: Text(resItem.servicename ?? "", style: kMontserrat18))],
                                                ),
                                              if (resItem.placename != null) const Divider(),
                                              if (resItem.placename != null)
                                                Row(children: [
                                                  Image.asset("assets/icon/place.png", height: W / 18, width: W / 18, color: Colors.black),
                                                  SizedBox(width: W / 60),
                                                  Text(resItem.placename, style: kProxima17)
                                                ]),
                                              if (resItem.staffname != null) const Divider(),
                                              if (resItem.staffname != null)
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("Staff Name".tr(), style: kProxima17),
                                                    Expanded(child: Text(" : ${resItem.staffname}", style: kMontserrat16))
                                                  ],
                                                ),
                                              if (resItem.netCtotal != 0) const Divider(),
                                              if (resItem.netCtotal != 0)
                                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                  Text("Total Price".tr(), style: kProxima17),
                                                  Expanded(
                                                      child: Text(" : ${resItem.netCtotal.toStringAsFixed(1)} ${resItem.currencycode} ".tr(),
                                                          style: kMontserrat16))
                                                ]),
                                              if (resItem.resstart != null) const Divider(),
                                              IntrinsicHeight(
                                                  child: Row(children: [
                                                if (resItem.resstart != null)
                                                  Expanded(
                                                      child: Column(
                                                    children: [
                                                      Text("Start Time".tr(), style: kProxima17),
                                                      Text(DateFormat("HH:mm  dd MMM yyyy").format(resItem.resstart!).tr(), style: kMontserrat16)
                                                    ],
                                                  )),
                                                if (resItem.resend != null) const VerticalDivider(),
                                                if (resItem.resend != null)
                                                  Expanded(
                                                      child: Column(
                                                    children: [
                                                      Text("End Time".tr(), style: kProxima17),
                                                      Text(DateFormat("HH:mm  dd MMM yyyy").format(resItem.resend!).tr(), style: kMontserrat16)
                                                    ],
                                                  ))
                                              ])),
                                            ]),
                                          ),
                                        ],
                                      ));
                                }));
                  }).toList()))
                ],
              ));
        });
  }
}

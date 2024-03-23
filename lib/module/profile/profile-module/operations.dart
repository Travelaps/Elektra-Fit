import 'package:elektra_fit/global/index.dart';
import 'package:flutter/material.dart';

class MyOperations extends StatefulWidget {
  const MyOperations({super.key});

  @override
  State<MyOperations> createState() => _MyOperationsState();
}

class _MyOperationsState extends State<MyOperations> {
  final service = GetIt.I<ProfileService>();

  @override
  void initState() {
    service.ressList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("My Operations".tr())),
      body: StreamBuilder(
          stream: service.res$.stream,
          builder: (context, snapshot) {
            if (service.res$.value == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (service.res$.value!.isEmpty) {
              return Center(child: Text("No found Reservations".tr(), style: kMontserrat18));
            }
            return DefaultTabController(
                length: service.res$.value!.length,
                child: Column(
                  children: [
                    TabBar(
                        isScrollable: true,
                        indicatorColor: config.primaryColor,
                        unselectedLabelStyle: kMontserrat18,
                        labelStyle: kMontserrat18.copyWith(color: config.primaryColor),
                        tabs: service.res$.value!.keys.map((e) {
                          return Tab(text: e);
                        }).toList()),
                    Expanded(
                        child: TabBarView(
                            children: service.res$.value!.keys.map((res) {
                      var item = service.res$.value?[res];
                      return item!.isEmpty
                          ? Center(child: Text("no found $res"))
                          : SizedBox(
                              height: H * 0.9,
                              width: W,
                              child: ListView.builder(
                                itemCount: item?.length,
                                itemBuilder: (context, index) {
                                  var resItem = item?[index];
                                  return Container(
                                    padding: paddingAll10,
                                    margin: marginAll10,
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius10, boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.6), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 3)),
                                    ]),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [Expanded(child: Text("Name".tr(), style: kProxima17)), Spacer(), Expanded(child: Text(resItem!.guestname ?? "", style: kProxima17))],
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [Expanded(child: Text("Category".tr(), style: kProxima17)), Spacer(), Expanded(child: Text(resItem!.depname ?? "", style: kProxima17))],
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [Expanded(child: Text("Service Name".tr(), style: kProxima17)), Spacer(), Expanded(child: Text(resItem!.servicename ?? "", style: kProxima17))],
                                        ),
                                        if (resItem.staffname != null) Divider(),
                                        if (resItem.staffname != null)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [Expanded(child: Text("Staff Name".tr(), style: kProxima17)), Spacer(), Expanded(child: Text(resItem!.staffname ?? "", style: kProxima17))],
                                          ),
                                        if (resItem.creationdate != null) Divider(),
                                        if (resItem.creationdate != null)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(child: Text("Creation Time".tr(), style: kProxima17)),
                                              Spacer(),
                                              Expanded(child: Text("${DateFormat("dd MMM yyyy").format(resItem!.creationdate)}".tr(), style: kProxima17)),
                                            ],
                                          ),
                                        if (resItem.resstart != null) Divider(),
                                        if (resItem.resstart != null)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(child: Text("Reservation Start Time".tr(), style: kProxima17)),
                                              Spacer(),
                                              Expanded(child: Text("${DateFormat("dd MMM yyyy HH:mm").format(resItem.resstart!)}".tr(), style: kProxima17)),
                                            ],
                                          ),
                                        if (resItem.resend != null) Divider(),
                                        if (resItem.resend != null)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(child: Text("Reservation End Time".tr(), style: kProxima17)),
                                              Spacer(),
                                              Expanded(child: Text("${DateFormat("dd MMM yyyy  HH:mm").format(resItem.resend!)}".tr(), style: kProxima17)),
                                            ],
                                          ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(child: Text("Total Price".tr(), style: kProxima17)),
                                            Spacer(),
                                            Expanded(child: Text("${resItem.netCtotal.toStringAsFixed(1)} ${resItem.currencycode} ".tr(), style: kProxima17)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                    }).toList()))
                  ],
                ));
          }),
    );
    // body: DefaultTabController(z
    //   child: Scaffold(
    //     body: ,
    //   ),
    // ));
    // return Scaffold (
    //   appBar: AppBar(title: Text("My Operations".tr())),
    //   body: StreamBuilder(
    //       stream: service.reservation$.stream,
    //       builder: (context, snapshot) {
    //         if (service.reservation$.value == null) {
    //           return Center(child: CircularProgressIndicator(color: config.primaryColor));
    //         } else if (service.reservation$.value!.isEmpty) {
    //           return Center(child: Text("No Operations Found".tr()));
    //         }
    //         return SizedBox(
    //             height: H * 0.8,
    //             child: ListView.builder(
    //               itemCount: service.reservation$.value!.length,
    //               itemBuilder: (context, index) {
    //                 var item = service.reservation$.value?[index];
    //                 return Container(
    //                   padding: paddingAll10,
    //                   margin: marginAll5,
    //                   decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius10, boxShadow: [
    //                     BoxShadow(color: Colors.black.withOpacity(0.6), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 3)),
    //                   ]),
    //                   child: Column(
    //                     children: [
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Text("Name".tr(), style: kProxima17),
    //                           Text(item?.guestname ?? "", style: kProxima17),
    //                         ],
    //                       ),
    //                       Divider(),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [Text("Category".tr(), style: kProxima17), Text(item?.depname ?? "", style: kProxima17)],
    //                       ),
    //                       Divider(),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [Text("Service Name".tr(), style: kProxima17), Text(item?.servicename ?? "", style: kProxima17)],
    //                       ),
    //                       Divider(),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Text("Creation Date".tr(), style: kProxima17),
    //                           Text("${DateFormat("MMM dd yyyy").format(item!.creationdate)}".tr(), style: kProxima17),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 );
    //               },
    //             ));
    //       }),
    // );
  }
}

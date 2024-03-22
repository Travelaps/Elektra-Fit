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
    // service.reservationList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("data")),
      body: StreamBuilder(
          stream: service.res$.stream,
          builder: (context, snapshot) {
            if (service.res$.value == null) {
              return Center(child: CircularProgressIndicator());
            } else if (service.res$.value!.isEmpty) {
              return Center(child: Text("No found Reservations".tr(), style: kMontserrat18));
            }
            return DefaultTabController(
                length: service.res$.value!.length,
                child: Column(
                  children: [
                    TabBar(
                        tabs: service.res$.value!.keys.map((e) {
                      return Tab(text: e);
                    }).toList()),
                    Expanded(
                        child: TabBarView(
                            children: service.res$.value!.keys.map((res) {
                      var item = service.res$.value?[res];
                      return SizedBox(
                        height: H * 0.9,
                        width: W,
                        child: ListView.builder(
                          itemCount: item?.length,
                          itemBuilder: (context, index) {
                            var resItem = item?[index];
                            return Container(
                              padding: paddingAll10,
                              margin: marginAll5,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius10, boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(0.6), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 3)),
                              ]),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [Text("Name".tr(), style: kProxima17), Text(resItem!.guestname ?? "", style: kProxima17)],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [Text("Category".tr(), style: kProxima17), Text(resItem!.depname ?? "", style: kProxima17)],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [Text("Service Name".tr(), style: kProxima17), Text(resItem!.servicename ?? "", style: kProxima17)],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Creation Date".tr(), style: kProxima17),
                                      Text("${DateFormat("MMM dd yyyy").format(resItem!.creationdate)}".tr(), style: kProxima17),
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

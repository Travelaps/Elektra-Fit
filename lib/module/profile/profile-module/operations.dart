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
                                itemCount: item.length,
                                itemBuilder: (context, index) {
                                  var resItem = item[index];
                                  return Container(
                                    padding: paddingAll10,
                                    margin: marginAll10,
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius10, boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.9), spreadRadius: 2, blurRadius: 10, offset: Offset(0, 7)),
                                    ]),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (resItem.servicename != "")
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [Expanded(child: Text(resItem.servicename ?? "", style: kMontserrat18))],
                                          ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: borderRadius10,
                                              color: res == 'Planned'.tr()
                                                  ? config.primaryColor
                                                  : res == 'Completed'.tr()
                                                      ? Colors.grey
                                                      : Colors.green),
                                          padding: paddingAll5,
                                          child: Row(
                                            children: [
                                              if (res == "Completed") Image.asset("assets/icon/completion.png", height: W / 18, width: W / 18, fit: BoxFit.cover, color: Colors.white),
                                              if (res == "Planned") Image.asset("assets/icon/planned.png", height: W / 18, width: W / 18, fit: BoxFit.cover, color: Colors.white),
                                              if (res == "To be planned") Image.asset("assets/icon/tobeplanned.png", height: W / 18, width: W / 18, fit: BoxFit.cover, color: Colors.white),
                                              SizedBox(width: W / 40),
                                              Text(res.tr(), style: kMontserrat17.copyWith(color: Colors.white))
                                            ],
                                          ),
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
                                            children: [Text("Staff Name".tr(), style: kProxima17), Expanded(child: Text(" : ${resItem.staffname}", style: kMontserrat16))],
                                          ),
                                        if (resItem.netCtotal != 0) const Divider(),
                                        if (resItem.netCtotal != 0)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Total Price".tr(), style: kProxima17),
                                              Expanded(child: Text(" : ${resItem.netCtotal.toStringAsFixed(1)} ${resItem.currencycode} ".tr(), style: kMontserrat16)),
                                            ],
                                          ),
                                        if (resItem.resstart != null) const Divider(),
                                        IntrinsicHeight(
                                            child: Row(children: [
                                          if (resItem.resstart != null)
                                            Expanded(
                                                child: Column(
                                              children: [Text("Start Time".tr(), style: kProxima17), Text(DateFormat("HH:mm  dd MMM yyyy").format(resItem.resstart!).tr(), style: kMontserrat16)],
                                            )),
                                          if (resItem.resend != null) const VerticalDivider(),
                                          if (resItem.resend != null)
                                            Expanded(
                                                child: Column(
                                              children: [Text("End Time".tr(), style: kProxima17), Text(DateFormat("HH:mm  dd MMM yyyy").format(resItem.resend!).tr(), style: kMontserrat16)],
                                            ))
                                        ])),
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

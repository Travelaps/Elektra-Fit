import 'package:elektra_fit/global/index.dart';
import 'package:flutter/material.dart';

class MyOperations extends StatefulWidget {
  const MyOperations({super.key});

  @override
  State<MyOperations> createState() => _MyOperationsState();
}

class _MyOperationsState extends State<MyOperations> {
  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: Text("My Operations".tr()), actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyOperationDetail()));
                },
                child: Icon(Icons.menu, color: Colors.white, size: W / 14)),
          )
        ]),
        body: Reservation()
        // StreamBuilder(
        //     stream: service.res$.stream,
        //     builder: (context, snapshot) {
        //       if (service.res$.value == null) {
        //         return Center(child: CircularProgressIndicator(color: config.primaryColor));
        //       }
        //       return DefaultTabController(
        //           length: service.res$.value!.length,
        //           child: Column(
        //             children: [
        //               TabBar(
        //                   isScrollable: true,
        //                   indicatorColor: config.primaryColor,
        //                   unselectedLabelStyle: kMontserrat18,
        //                   labelStyle: kMontserrat18.copyWith(color: config.primaryColor),
        //                   tabs: service.res$.value!.keys.map((e) {
        //                     return Tab(text: e);
        //                   }).toList()),
        //               Expanded(
        //                   child: TabBarView(
        //                       children: service.res$.value!.keys.map((res) {
        //                 var item = service.res$.value?[res];
        //                 return item!.isEmpty
        //                     ? Center(
        //                         child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         children: [
        //                           Text(res, style: kProxima17),
        //                           SizedBox(width: W / 70),
        //                           Text("reservation was not found".tr(), style: kProxima17),
        //                         ],
        //                       ))
        //                     : SizedBox(
        //                         height: H * 0.9,
        //                         width: W,
        //                         child: ListView.builder(
        //                             itemCount: item.length,
        //                             itemBuilder: (context, index) {
        //                               var resItem = item[index];
        //                               return Container(
        //                                   padding: paddingAll10,
        //                                   margin: marginAll10,
        //                                   decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius10, boxShadow: [
        //                                     BoxShadow(color: Colors.black.withOpacity(0.9), spreadRadius: 2, blurRadius: 10, offset: Offset(0, 7)),
        //                                   ]),
        //                                   child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //                                     if (resItem.servicename != "")
        //                                       Row(
        //                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                                         children: [Expanded(child: Text(resItem.servicename ?? "", style: kMontserrat18))],
        //                                       ),
        //                                     Container(
        //                                         decoration: BoxDecoration(
        //                                             borderRadius: borderRadius10,
        //                                             color: res == 'Planned'.tr()
        //                                                 ? config.primaryColor
        //                                                 : res == 'Completed'.tr()
        //                                                     ? Colors.grey
        //                                                     : Colors.green),
        //                                         padding: paddingAll5,
        //                                         child: Row(children: [
        //                                           if (res == "Completed".tr())
        //                                             Image.asset("assets/icon/completion.png",
        //                                                 height: W / 18, width: W / 18, fit: BoxFit.cover, color: Colors.white),
        //                                           if (res == "Planned".tr())
        //                                             Image.asset("assets/icon/planned.png",
        //                                                 height: W / 18, width: W / 18, fit: BoxFit.cover, color: Colors.white),
        //                                           if (res == "To be planned".tr())
        //                                             Image.asset("assets/icon/tobeplanned.png",
        //                                                 height: W / 18, width: W / 18, fit: BoxFit.cover, color: Colors.white),
        //                                           SizedBox(width: W / 40),
        //                                           Text(res.tr(), style: kMontserrat17.copyWith(color: Colors.white))
        //                                         ])),
        //                                     if (resItem.placename != null) const Divider(),
        //                                     if (resItem.placename != null)
        //                                       Row(children: [
        //                                         Image.asset("assets/icon/place.png", height: W / 18, width: W / 18, color: Colors.black),
        //                                         SizedBox(width: W / 60),
        //                                         Text(resItem.placename, style: kProxima17)
        //                                       ]),
        //                                     if (resItem.staffname != null) const Divider(),
        //                                     if (resItem.staffname != null)
        //                                       Row(
        //                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                                         children: [
        //                                           Text("Staff Name".tr(), style: kProxima17),
        //                                           Expanded(child: Text(" : ${resItem.staffname}", style: kMontserrat16))
        //                                         ],
        //                                       ),
        //                                     if (resItem.netCtotal != 0) const Divider(),
        //                                     if (resItem.netCtotal != 0)
        //                                       Row(
        //                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                                         children: [
        //                                           Text("Total Price".tr(), style: kProxima17),
        //                                           Expanded(
        //                                               child: Text(" : ${resItem.netCtotal.toStringAsFixed(1)} ${resItem.currencycode} ".tr(),
        //                                                   style: kMontserrat16)),
        //                                         ],
        //                                       ),
        //                                     if (resItem.resstart != null) const Divider(),
        //                                     IntrinsicHeight(
        //                                         child: Row(children: [
        //                                       if (resItem.resstart != null)
        //                                         Expanded(
        //                                             child: Column(
        //                                           children: [
        //                                             Text("Start Time".tr(), style: kProxima17),
        //                                             Text(DateFormat("HH:mm  dd MMM yyyy").format(resItem.resstart!).tr(), style: kMontserrat16)
        //                                           ],
        //                                         )),
        //                                       if (resItem.resend != null) const VerticalDivider(),
        //                                       if (resItem.resend != null)
        //                                         Expanded(
        //                                             child: Column(
        //                                           children: [
        //                                             Text("End Time".tr(), style: kProxima17),
        //                                             Text(DateFormat("HH:mm  dd MMM yyyy").format(resItem.resend!).tr(), style: kMontserrat16)
        //                                           ],
        //                                         ))
        //                                     ])),
        //                                   ]));
        //                             }));
        //               }).toList()))
        //             ],
        //           ));
        //     }),
        );
  }
}

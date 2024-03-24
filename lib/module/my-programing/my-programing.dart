import 'package:flutter/material.dart';

import '../../global/index.dart';

class MyPrograming extends StatefulWidget {
  const MyPrograming({Key? key}) : super(key: key);

  @override
  State<MyPrograming> createState() => _MyProgramingState();
}

class _MyProgramingState extends State<MyPrograming> {
  final service = GetIt.I<MyProgramingService>();

  @override
  void initState() {
    service.spaGroupActivityTimetableMembersList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return DefaultTabController(
      animationDuration: Durations.extralong1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Programs & Activities'.tr()),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.white,
            indicatorPadding: paddingAll10,
            isScrollable: false,
            labelPadding: paddingAll5,
            tabs: [
              Tab(iconMargin: EdgeInsets.zero, child: Text('My Programs'.tr(), style: kMontserrat18.copyWith(color: Colors.white))),
              Tab(child: Text('My Activity'.tr(), style: kMontserrat18.copyWith(color: Colors.white))),
            ],
          ),
        ),
        body: TabBarView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            myPrograms(context, W),
            StreamBuilder(
                stream: service.spaGroupActivityMember$.stream,
                builder: (context, snapshot) {
                  if (service.spaGroupActivityMember$.value == null) {
                    return Center(child: CircularProgressIndicator());
                  } else if (service.spaGroupActivityMember$.value!.isEmpty) {
                    return Center(
                        child: Text(
                      "You do not have any activity records yet.".tr(),
                    ));
                  }
                  return SizedBox(
                    height: H * 0.9,
                    child: ListView.builder(
                      itemCount: service.spaGroupActivityMember$.value!.length,
                      itemBuilder: (context, index) {
                        var item = service.spaGroupActivityMember$.value?[index];
                        if (item != null) {
                          return Container(
                              margin: marginAll10,
                              width: W,
                              decoration: BoxDecoration(
                                  borderRadius: borderRadius10,
                                  color: Colors.white,
                                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 5, blurRadius: 7, offset: const Offset(0, 1))]),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Stack(children: [
                                  ClipRRect(
                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                      child: CachedNetworkImage(
                                          imageUrl: item.photourl ?? "https://files.cdn.elektraweb.com/bdcac343/24277/images/3c96c5fb-3c3d-49d1-9ea9-9922ed6be380.png",
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => CircularProgressIndicator(color: config.primaryColor),
                                          errorWidget: (context, url, error) => const Icon(Icons.error))),
                                  if (item.level != null && item.level! < 6)
                                    Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          padding: paddingAll5,
                                          decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.only(topLeft: Radius.circular(10))),
                                          child: Row(children: [
                                            Icon(Icons.star_outlined, color: getLevelDescriptionColor(item?.level)),
                                            SizedBox(width: W / 40),
                                            Text(getLevelDescription(item.level), style: kMontserrat19.copyWith(color: Colors.white))
                                          ]),
                                        ))
                                ]),
                                Padding(
                                  padding: paddingAll5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.name ?? '', style: kMontserrat19, textAlign: TextAlign.center),
                                      const Divider(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Event Venue".tr(), style: kProxima17),
                                          Row(children: [
                                            Image.asset("assets/icon/place.png", width: W / 18, height: W / 18, fit: BoxFit.cover),
                                            SizedBox(width: W / 60),
                                            Text("${item.placename}", style: kProxima17)
                                          ]),
                                        ],
                                      ),
                                      const Divider(),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        Text("Instructor name".tr(), style: kProxima17),
                                        Text("${item.trainername}", style: kProxima17),
                                      ]),
                                      const Divider(),
                                      IntrinsicHeight(
                                          child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        if (item.startTime != null)
                                          Row(children: [
                                            Image.asset("assets/icon/calender.png", width: W / 18, height: W / 18, fit: BoxFit.cover),
                                            SizedBox(width: W / 40),
                                            Text(DateFormat("MMM d").format(item.startTime!), style: kProxima17)
                                          ]),
                                        const VerticalDivider(),
                                        if (item.startTime != null)
                                          Row(children: [
                                            Image.asset("assets/icon/clock2.png", width: W / 20, height: W / 20, fit: BoxFit.cover),
                                            SizedBox(width: W / 40),
                                            Text(DateFormat("HH:mm").format(item.startTime!), style: kProxima17)
                                          ]),
                                        const VerticalDivider(),
                                        if (item.duration != null)
                                          Row(children: [
                                            Image.asset("assets/icon/continue.png", width: W / 20, height: W / 20, fit: BoxFit.cover),
                                            SizedBox(width: W / 40),
                                            Text("${item.duration} min".tr(), style: kProxima17)
                                          ])
                                      ])),
                                    ],
                                  ),
                                ),

                                // SizedBox(height: W / 60),
                              ]));
                        }
                        return null;
                        // return Container(
                        //   padding: paddingAll10,
                        //   child: Stack(
                        //     children: [
                        //       ClipRRect(
                        //         borderRadius: borderRadius10,
                        //         child: CachedNetworkImage(
                        //           imageUrl: item?.photourl ?? "https://images.pexels.com/photos/841131/pexels-photo-841131.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                        //           fit: BoxFit.cover,
                        //           width: W,
                        //           height: W / 1.6,
                        //           placeholder: (context, url) => Center(child: CircularProgressIndicator(color: config.primaryColor)),
                        //           errorWidget: (context, url, error) => const Icon(Icons.error),
                        //         ),
                        //       ),
                        //       if (item?.name != null)
                        //         Positioned.fill(
                        //             child: Container(
                        //           alignment: Alignment.center,
                        //           decoration: BoxDecoration(
                        //               gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.4)]),
                        //               borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                        //               boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 1))]),
                        //           child: Text(
                        //             "${item?.name}",
                        //             style: kAxiforma19.copyWith(color: Colors.white),
                        //           ),
                        //         )),
                        //       if (item?.startTime != null)
                        //         Positioned(
                        //             top: 0,
                        //             left: 0,
                        //             right: 0,
                        //             child: Container(
                        //               padding: paddingAll5,
                        //               child: Row(
                        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                 children: [
                        //                   Row(
                        //                     children: [
                        //                       Image.asset("assets/icon/calender.png", fit: BoxFit.cover, height: W / 20, width: W / 20, color: Colors.white),
                        //                       SizedBox(width: W / 40),
                        //                       Text(DateFormat("MMM d").format(item!.startTime!), style: kMontserrat18.copyWith(color: Colors.white)),
                        //                     ],
                        //                   ),
                        //                   if (item.duration != null)
                        //                     Row(
                        //                       children: [
                        //                         Image.asset("assets/icon/clock.png", fit: BoxFit.cover, height: W / 20, width: W / 20, color: Colors.white),
                        //                         SizedBox(width: W / 40),
                        //                         Text("${item.duration} min".tr(), style: kMontserrat18.copyWith(color: Colors.white)),
                        //                       ],
                        //                     ),
                        //                 ],
                        //               ),
                        //             )),
                        //       if (item?.trainername != null)
                        //         Positioned(
                        //             bottom: 0,
                        //             left: 0,
                        //             right: 0,
                        //             child: Container(
                        //                 padding: paddingAll5,
                        //                 child: Row(children: [
                        //                   Image.asset("assets/icon/teacher.png", fit: BoxFit.cover, height: W / 20, width: W / 20, color: Colors.white),
                        //                   SizedBox(width: W / 40),
                        //                   Text(item!.trainername.toString(), style: kMontserrat18.copyWith(color: Colors.white)),
                        //                 ])))
                        //     ],
                        //   ),
                        // );
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Padding myPrograms(BuildContext context, double W) {
    return Padding(
      padding: paddingAll10,
      child: Column(
        children: member$.value!.map((item) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SportDetails()));
            },
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: borderRadius10,
                    child: CachedNetworkImage(
                        imageUrl: member$.value?.first.program.first.exercisephotourl ?? "https://www.skechers.com.tr/blog/wp-content/uploads/2023/03/fitnes-770x513.jpg",
                        placeholder: (context, url) => CircularProgressIndicator(color: config.primaryColor),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        fit: BoxFit.cover)),
                Positioned.fill(
                  bottom: 0,
                  child: Container(
                      width: W / 2.18,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.4)]),
                          borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 1))]),
                      child: Text('Program'.tr(), style: kAxiforma20.copyWith(color: Colors.white), textAlign: TextAlign.center)),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

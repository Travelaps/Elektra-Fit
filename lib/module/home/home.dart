import 'package:flutter/material.dart';

import '../../global/index.dart';
import '../../widget/index.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeService = GetIt.I<HomeService>();

  @override
  void initState() {
    homeService.spaGroupActivityTimetableList();
    homeService.spaGroupActivityTimetableMembersList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Lessons".tr())),
      body: Column(
        children: [
          Container(),
          StreamBuilder(
              stream: homeService.spaGroupActivityMember$.stream,
              builder: (context, snapshot) {
                if (homeService.spaGroupActivityMember$.value == null) {
                  return Center(child: CLoading());
                } else if (homeService.spaGroupActivityMember$.value!.isNotEmpty) {
                  return SizedBox(
                    height: H,
                    width: W,
                    child: ListView.builder(
                      itemCount: homeService.spaGroupActivityMember$.value!.length,
                      itemBuilder: (context, index) {
                        var item = homeService.spaGroupActivityMember$.value?[index];
                        return Container(
                          margin: marginAll10,
                          height: W / 1.1,
                          decoration: BoxDecoration(
                              color: isDarkMode$.value ? Colors.black87 : Colors.white,
                              boxShadow: [
                                BoxShadow(color: isDarkMode$.value ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.7), spreadRadius: 2, blurRadius: 5, offset: const Offset(0, 4)),
                              ],
                              borderRadius: borderRadius10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                                  child: Stack(children: [
                                    SizedBox(
                                        width: W,
                                        height: W / 1.6,
                                        child: CachedNetworkImage(
                                            imageUrl: item?.photourl ?? "",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => CLoading(),
                                            errorWidget: (context, url, error) => const Icon(Icons.error))),
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: borderRadius10,
                                          gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.5)])),
                                      child: SizedBox(width: W, height: W / 1.6),
                                    ),
                                    Positioned(
                                        top: 10,
                                        left: 10,
                                        child: Text(
                                          item?.name ?? ''.tr(),
                                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                                        ))
                                  ])),
                              Spacer(),
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(height: W / 15, width: W / 15, child: Image.asset("assets/icon/calender.png")),
                                          // Text("${DateFormat("MMM-dd").format(itemstartTime)}", style: kProxima16),
                                        ],
                                      ),
                                    ),
                                    const VerticalDivider(width: 2, endIndent: 2, indent: 2),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(height: W / 15, width: W / 15, child: Image.asset("assets/icon/hours.png")),
                                          Text("19.00", style: kProxima16),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(indent: 3, endIndent: 3),
                              Container(
                                padding: paddingAll5,
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: W / 15,
                                        height: W / 15,
                                        child: Image.asset("assets/icon/continune.png", fit: BoxFit.cover, color: config.primaryColor),
                                      ),
                                      Text("Professional Trainer".tr(), style: kMontserrat18.copyWith(color: config.primaryColor))
                                    ],
                                  ),
                                  Text("Hamza Alfawer", style: kMontserrat18)
                                ]),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                  // return Column(
                  //   children: [
                  //
                  //     Container(
                  //       margin: marginAll10,
                  //       height: W / 1.1,
                  //       decoration: BoxDecoration(
                  //           color: isDarkMode$.value ? Colors.black87 : Colors.white,
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: isDarkMode$.value ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.7),
                  //               spreadRadius: 2,
                  //               blurRadius: 5,
                  //               offset: const Offset(0, 4),
                  //             ),
                  //           ],
                  //           borderRadius: const BorderRadius.all(Radius.circular(10))),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           ClipRRect(
                  //             borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                  //             child: Stack(
                  //               children: [
                  //                 SizedBox(
                  //                   width: W,
                  //                   height: W / 1.6,
                  //                   child: Image.asset("assets/image/sport6.jpg", fit: BoxFit.cover),
                  //                 ),
                  //                 DecoratedBox(
                  //                   decoration: BoxDecoration(
                  //                     borderRadius: const BorderRadius.all(Radius.circular(10)),
                  //                     gradient: LinearGradient(
                  //                       begin: Alignment.bottomCenter,
                  //                       end: Alignment.topCenter,
                  //                       colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                  //                     ),
                  //                   ),
                  //                   child: SizedBox(width: W, height: W / 1.6),
                  //                 ),
                  //                 Positioned(
                  //                   top: 10,
                  //                   left: 10,
                  //                   child: Text(
                  //                     'Gym'.tr(),
                  //                     style: TextStyle(
                  //                       color: Colors.white,
                  //                       fontSize: 20,
                  //                       fontWeight: FontWeight.bold,
                  //                       fontFamily: "Montserrat",
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           Spacer(),
                  //           IntrinsicHeight(
                  //             child: Row(
                  //               crossAxisAlignment: CrossAxisAlignment.center,
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Expanded(
                  //                   child: Row(
                  //                     crossAxisAlignment: CrossAxisAlignment.center,
                  //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                     children: [
                  //                       SizedBox(height: W / 15, width: W / 15, child: Image.asset("assets/icon/calender.png")),
                  //                       Text("17 Jan", style: kProxima16),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 const VerticalDivider(width: 2, endIndent: 2, indent: 2),
                  //                 Expanded(
                  //                   child: Row(
                  //                     crossAxisAlignment: CrossAxisAlignment.center,
                  //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                     children: [
                  //                       SizedBox(height: W / 15, width: W / 15, child: Image.asset("assets/icon/hours.png")),
                  //                       Text("19.00", style: kProxima16),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           Divider(indent: 3, endIndent: 3),
                  //           Container(
                  //             padding: paddingAll5,
                  //             child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  //               Row(
                  //                 children: [
                  //                   SizedBox(
                  //                     width: W / 15,
                  //                     height: W / 15,
                  //                     child: Image.asset(
                  //                       "assets/icon/continune.png",
                  //                       fit: BoxFit.cover,
                  //                       color: config.primaryColor,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     "Professional Trainer".tr(),
                  //                     style: kMontserrat18.copyWith(color: config.primaryColor),
                  //                   )
                  //                 ],
                  //               ),
                  //               Text(" Hamza Alfawer", style: kMontserrat18)
                  //             ]),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // );
                } else
                  return Center(
                    child: Text(""),
                  );
              }),
        ],
      ),
    );
  }
}

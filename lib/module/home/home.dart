import 'package:elektra_fit/module/home/spa-group-activity-detail/spa-group-activity-detail.dart';
import 'package:elektra_fit/widget/Cloading.dart';
import 'package:flutter/material.dart';

import '../../global/index.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeService = GetIt.I<HomeService>();
  BehaviorSubject<DateTime> selectedDate$ = BehaviorSubject.seeded(DateTime.now());

  @override
  void initState() {
    homeService.spaGroupActivityTimetableList();
    // homeService.selectedDate$ = BehaviorSubject.seeded(DateTime.now());

    super.initState();
  }

  @override
  void dispose() {
    // homeService.selectedDate$.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: Text("Lessons".tr())),
        body: StreamBuilder(
            stream: Rx.combineLatest2(selectedDate$, homeService.spaGroupActivity$, (a, b) => null),
            builder: (context, snapshot) {
              if (homeService.spaGroupActivity$.value == null) {
                return Center(child: CircularProgressIndicator());
              } else if (homeService.spaGroupActivity$.value!.isEmpty) {
                return Center(
                  child: Text("no found group activity"),
                );
              }
              final today = DateTime.now();
              return Container(
                child: Column(
                  children: [
                    SizedBox(
                        height: W / 4,
                        width: W,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 30,
                            itemBuilder: (BuildContext context, int index) {
                              DateTime date = today.add(Duration(days: index));
                              return Container(
                                  width: W / 5,
                                  margin: marginAll5,
                                  decoration: BoxDecoration(
                                    borderRadius: borderRadius10,
                                    color: selectedDate$.value.year == date.year && selectedDate$.value.month == date.month && selectedDate$.value.day == date.day ? Colors.black87 : Colors.white,
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 3)),
                                    ],
                                  ),
                                  child: InkWell(
                                      onTap: () {
                                        selectedDate$.add(date);
                                      },
                                      child: Center(
                                          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                        Text(
                                          DateFormat("EEE").format(date).tr(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: selectedDate$.value.year == date.year && selectedDate$.value.month == date.month && selectedDate$.value.day == date.day
                                                  ? Colors.white
                                                  : Colors.black87),
                                        ),
                                        Container(
                                          padding: paddingAll5,
                                          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                          child: Text(
                                            DateFormat('d').format(date),
                                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ]))));
                            })),
                    SizedBox(
                      height: H * 0.65,
                      width: W,
                      child: ListView.builder(
                        itemCount: homeService.spaGroupActivity$.value!.length,
                        itemBuilder: (context, index) {
                          var item = homeService.spaGroupActivity$.value?[index];

                          return InkWell(
                            onTap: () {
                              Navigator.push(context, RouteAnimation.createRoute(SpaGroupActivityDetail(item: item!), 0, 1));
                            },
                            child: Container(
                              margin: marginAll10,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: borderRadius10,
                                boxShadow: [
                                  BoxShadow(color: Colors.black.withOpacity(0.6), spreadRadius: 3, blurRadius: 10, offset: const Offset(0, 3)),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: borderRadius10,
                                    child: CachedNetworkImage(
                                      imageUrl: item?.photoUrl ?? "",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: borderRadius10,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      padding: paddingAll10,
                                      alignment: Alignment.center,
                                      child: Text(
                                        item?.name ?? "",
                                        style: kAxiforma19.copyWith(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        padding: paddingAll10,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/icon/clock.png",
                                              width: W / 20,
                                              height: W / 20,
                                              fit: BoxFit.cover,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: W / 40),
                                            Text("${item?.duration ?? ""} min", style: kMontserrat17.copyWith(color: Colors.white))
                                          ],
                                        ),
                                      )),
                                  Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        padding: paddingAll10,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star_outlined,
                                              color: getLevelDescriptionColor(item?.level),
                                            ),
                                            SizedBox(width: W / 40),
                                            Text(getLevelDescription(item?.level), style: kMontserrat17.copyWith(color: Colors.white))
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
              // final today = DateTime.now();
              // return SingleChildScrollView(
              //     child: Container(
              //         child: Column(
              //   children: [
              //     SizedBox(
              //         height: W / 4,
              //         width: W,
              //         child: ListView.builder(
              //             scrollDirection: Axis.horizontal,
              //             itemCount: 30,
              //             itemBuilder: (BuildContext context, int index) {
              //               DateTime date = today.add(Duration(days: index));
              //               return Container(
              //                   width: W / 5,
              //                   margin: marginAll5,
              //                   decoration: BoxDecoration(
              //                     borderRadius: borderRadius10,
              //                     color: selectedDate$.value.year == date.year && selectedDate$.value.month == date.month && selectedDate$.value.day == date.day ? Colors.black87 : Colors.white,
              //                     boxShadow: [
              //                       BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 3)),
              //                     ],
              //                   ),
              //                   child: InkWell(
              //                       onTap: () {
              //                         selectedDate$.add(date);
              //                       },
              //                       child: Center(
              //                           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //                         Text(
              //                           DateFormat("EEE").format(date).tr(),
              //                           style: TextStyle(
              //                               fontSize: 16,
              //                               fontWeight: FontWeight.bold,
              //                               color: selectedDate$.value.year == date.year && selectedDate$.value.month == date.month && selectedDate$.value.day == date.day
              //                                   ? Colors.white
              //                                   : Colors.black87),
              //                         ),
              //                         Container(
              //                           padding: paddingAll5,
              //                           decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              //                           child: Text(
              //                             DateFormat('d').format(date),
              //                             style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              //                           ),
              //                         )
              //                       ]))));
              //             })),
              //     if (homeService.spaGroupActivity$.value == null) Center(child: CircularProgressIndicator()),
              //     if (homeService.spaGroupActivity$.value!.isEmpty) Center(child: Text("no found spa group")),
              //     Container(
              //       height: W,
              //       child: ListView.builder(
              //         itemCount: homeService.spaGroupActivity$.value!.length,
              //         itemBuilder: (context, index) {
              //           var item = homeService.spaGroupActivity$.value?[index];
              //           if (selectedDate$.value == item!.startTime)
              //             return Container(
              //               child: Text(item.name ?? ""),
              //             );
              //         },
              //       ),
              //     )
              //   ],
              // )));
            }));
  }
}

// String getLevelDescription(int? level) {
//   String levelName = '';
//   switch (level) {
//     case 1:
//       levelName = 'Beginner';
//       break;
//     case 2:
//       levelName = 'Intermediate';
//       break;
//     case 3:
//       levelName = 'Advanced';
//       break;
//     case 4:
//       levelName = 'Expert';
//       break;
//     case 5:
//       levelName = 'Professional';
//       break;
//     default:
//       levelName = 'Unknown Level';
//   }
//   return levelName;
// }

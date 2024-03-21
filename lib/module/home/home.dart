import 'package:flutter/material.dart';

import '../../global/global-models.dart';
import '../../global/index.dart';
import '../../widget/index.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeService = GetIt.I<HomeService>();
  BehaviorSubject<DateTime> selectedDate$ = BehaviorSubject.seeded(DateTime.now());
  BehaviorSubject<bool> isFilter$ = BehaviorSubject.seeded(false);
  List<SpaGroupActivityModel> total = [];
  List<SpaGroupActivityModel> totalfilter = [];

  @override
  void initState() {
    homeService.spaGroupActivityTimetableList();
    // homeService.spaGroupActivityTimetableMembersList();
    super.initState();
  }

  @override
  void dispose() {
    // _selectedDate$.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: isFilter$.stream,
        builder: (context, snapshot) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Lessons".tr()),
                // actions: [
                //   InkWell(
                //       onTap: () {
                //         isFilter$.add(!isFilter$.value);
                //       },
                //       child: Padding(
                //         padding: paddingAll10,
                //         child: Icon(isFilter$.value ? Icons.filter_alt_off : Icons.filter_alt, color: Colors.white),
                //       ))
                // ],
              ),
              body: StreamBuilder(
                  stream: Rx.combineLatest2(selectedDate$, homeService.spaGroupActivity$, (a, b) => null),
                  builder: (context, snapshot) {
                    if (homeService.spaGroupActivity$.value == null) {
                      return Center(child: CircularProgressIndicator());
                    } else if (homeService.spaGroupActivity$.value!.isEmpty) {
                      return Center(
                        child: Text("There are currently no group activities available.".tr()),
                      );
                    }
                    final today = DateTime.now();

                    return Column(
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
                                          color:
                                              selectedDate$.value.year == date.year && selectedDate$.value.month == date.month && selectedDate$.value.day == date.day ? Colors.black87 : Colors.white,
                                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 3, blurRadius: 10, offset: const Offset(0, 3))]),
                                      child: InkWell(
                                          onTap: () async {
                                            selectedDate$.add(date);
                                            DateTime selectedDate = selectedDate$.value;
                                            totalfilter = homeService.spaGroupActivity$.value!.where((element) {
                                              DateTime activityDate = DateTime(element.startTime.year, element.startTime.month, element.startTime.day);
                                              return activityDate.year == selectedDate.year && activityDate.month == selectedDate.month && activityDate.day == selectedDate.day;
                                            }).toList();
                                          },
                                          child: Center(
                                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                            Text(DateFormat("EEE").format(date).tr(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: selectedDate$.value.year == date.year && selectedDate$.value.month == date.month && selectedDate$.value.day == date.day
                                                        ? Colors.white
                                                        : Colors.black87)),
                                            Container(
                                                padding: paddingAll5,
                                                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                                child: Text(DateFormat('d').format(date), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))
                                          ]))));
                                })),
                        SizedBox(
                          height: H * 0.65,
                          width: W,
                          child: ListView.builder(
                            itemCount: totalfilter.length,
                            itemBuilder: (context, index) {
                              var item = totalfilter[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, RouteAnimation.createRoute(SpaGroupActivityDetail(item: item!), 0, 1));
                                },
                                child: Container(
                                  margin: marginAll10,
                                  width: W,
                                  decoration: BoxDecoration(
                                      borderRadius: borderRadius10,
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 5, blurRadius: 7, offset: const Offset(0, 1))]),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(children: [
                                        ClipRRect(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                            child: CachedNetworkImage(
                                                imageUrl: item.photoUrl,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) => CircularProgressIndicator(color: config.primaryColor),
                                                errorWidget: (context, url, error) => const Icon(Icons.error))),
                                        Positioned(
                                            right: 0,
                                            top: 0,
                                            child: Container(
                                                padding: paddingAll5,
                                                decoration: BoxDecoration(
                                                    color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10))),
                                                child: Row(children: [
                                                  Image.asset("assets/icon/calender.png", width: W / 18, height: W / 18, fit: BoxFit.cover, color: Colors.white),
                                                  SizedBox(width: W / 40),
                                                  Text(DateFormat("MMM d").format(item.startTime), style: kMontserrat18.copyWith(color: Colors.white))
                                                ])))
                                      ]),
                                      // SizedBox(height: W / 60),
                                      Padding(padding: paddingAll5, child: Text(item.name, style: kMontserrat19, textAlign: TextAlign.center)),
                                      Padding(
                                          padding: paddingAll5,
                                          child: IntrinsicHeight(
                                              child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                            Row(children: [
                                              Icon(Icons.star_outlined, color: getLevelDescriptionColor(item.level)),
                                              SizedBox(width: W / 40),
                                              Text(getLevelDescription(item.level), style: kMontserrat17)
                                            ]),
                                            VerticalDivider(),
                                            Row(children: [
                                              Image.asset("assets/icon/clock.png", width: W / 20, height: W / 20, fit: BoxFit.cover),
                                              SizedBox(width: W / 40),
                                              Text("${item.duration} min", style: kMontserrat17)
                                            ])
                                          ]))),
                                      SizedBox(height: W / 60),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    );

                    // if (item?.duration != null)
                    //   Positioned(
                    //       right: 0,
                    //       bottom: 0,
                    //       child: Container(
                    //           padding: paddingAll10,
                    //           child: Row(children: [
                    //             Image.asset("assets/icon/clock.png", width: W / 20, height: W / 20, fit: BoxFit.cover, color: Colors.white),
                    //             SizedBox(width: W / 40),
                    //             Text("${item?.duration ?? ""} min", style: kMontserrat17.copyWith(color: Colors.white))
                    //           ]))),
                    // if (item?.level != null)
                    //   Positioned(
                    //       left: 0,
                    //       top: 0,
                    //       child: Container(
                    //           padding: paddingAll10,
                    //           child: Row(children: [
                    //             Icon(Icons.star_outlined, color: getLevelDescriptionColor(item?.level)),
                    //             SizedBox(width: W / 40),
                    //             Text(getLevelDescription(item?.level), style: kMontserrat17.copyWith(color: Colors.white))
                    //           ]))),
                    // if (item?.startTime != null)
                    //   Positioned(
                    //       left: 0,
                    //       bottom: 0,
                    //       child: Container(
                    //           padding: paddingAll10,
                    //           child: Row(children: [
                    //             Image.asset("assets/icon/calender.png", width: W / 20, height: W / 20, fit: BoxFit.cover, color: Colors.white),
                    //             SizedBox(width: W / 40),
                    //             Text(DateFormat("MMM d").format(item!.startTime), style: kMontserrat17.copyWith(color: Colors.white))
                    //           ]))),
                    //
                  }));
        });
  }

  String getLevelDescription(int? level) {
    String levelName = '';
    switch (level) {
      case 1:
        levelName = 'Beginner Level';
        break;
      case 2:
        levelName = 'Intermediate Level';
        break;
      case 3:
        levelName = 'Advanced Level';
        break;
      case 4:
        levelName = 'Expert Level';
        break;
      case 5:
        levelName = 'Professional Level';
        break;
      default:
        levelName = 'Unknown Level';
    }
    return levelName;
  }
//
// void getGroupActivityByDate(DateTime selectedDate) async {
//   // Verileri alma isteği yapılıyor
//   var response = await homeService.spaGroupActivityTimetableList();
//
//   // Başarılı bir yanıt alındığında işlemler yapılıyor
//   if (response.result) {
//     // Verileri gruplamak için bir harita oluşturuluyor
//     Map<DateTime, List<SpaGroupActivityModel>> groupedData = {};
//
//     for (var item in data) {
//       DateTime startTime = item.startTime;
//
//       if (!groupedData.containsKey(startTime)) {
//         groupedData[startTime] = [];
//       }
//       groupedData[startTime]?.add(item);
//     }
//
//     // Seçilen tarihteki verileri güncelle
//     homeService.spaGroupActivity$.add(groupedData[selectedDate]);
//   } else {
//     // Yanıt başarısızsa hata mesajını yazdır
//     print(response.message);
//   }
// }
}

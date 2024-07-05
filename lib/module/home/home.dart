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

    super.initState();
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
                return Center(child: CircularProgressIndicator(color: config.primaryColor));
              } else if (homeService.spaGroupActivity$.value!.isEmpty) {
                return Center(child: Text("There are currently no group activities available.".tr()));
              }

              final today = DateTime.now();
              DateTime selectedDate = selectedDate$.value;
              totalfilter = homeService.spaGroupActivity$.value!.where((element) {
                DateTime activityDate = DateTime(element.startTime.year, element.startTime.month, element.startTime.day);
                return activityDate.year == selectedDate.year && activityDate.month == selectedDate.month && activityDate.day == selectedDate.day;
              }).toList();
              return Column(children: [
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
                                  color: selectedDate$.value.year == date.year &&
                                          selectedDate$.value.month == date.month &&
                                          selectedDate$.value.day == date.day
                                      ? Colors.black87
                                      : Colors.white,
                                  boxShadow: [
                                    BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 3, blurRadius: 10, offset: const Offset(0, 3))
                                  ]),
                              child: InkWell(
                                  onTap: () async {
                                    selectedDate$.add(date);
                                  },
                                  child: Center(
                                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                    Text(DateFormat("EEE", Localizations.localeOf(context).languageCode).format(date).tr(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: selectedDate$.value.year == date.year &&
                                                    selectedDate$.value.month == date.month &&
                                                    selectedDate$.value.day == date.day
                                                ? Colors.white
                                                : Colors.black87)),
                                    Container(
                                        padding: paddingAll5,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(DateFormat('d', Localizations.localeOf(context).languageCode).format(date),
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            )))
                                  ]))));
                        })),
                SizedBox(
                    width: W,
                    height: H * 0.68,
                    child: totalfilter.isEmpty
                        ? Center(child: Text("No activities found for the selected date.".tr(), style: kProxima18))
                        : ListView.builder(
                            itemCount: totalfilter.length,
                            itemBuilder: (context, index) {
                              var item = totalfilter[index];
                              return groupActivityCard(context, item, W);
                            }))
              ]);
            }));
  }

  InkWell groupActivityCard(BuildContext context, SpaGroupActivityModel item, double W) {
    return InkWell(
        onTap: () => Navigator.push(context, RouteAnimation.createRoute(SpaGroupActivityDetail(item: item), 0, 1)),
        child: Container(
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
                        imageUrl: item.photoUrl,
                        fit: BoxFit.cover,
                        width: W,
                        height: W / 1.9,
                        placeholder: (context, url) => CircularProgressIndicator(color: config.primaryColor),
                        errorWidget: (context, url, error) => const Icon(Icons.error))),
                Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                        padding: paddingAll5,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: const BorderRadius.only(topLeft: Radius.circular(10))),
                        child: Row(children: [
                          Icon(Icons.star_outlined, color: getLevelDescriptionColor(item.level)),
                          SizedBox(width: W / 40),
                          Text(getLevelDescription(item.level).tr(), style: kMontserrat19.copyWith(color: Colors.white))
                        ])))
              ]),
              Padding(padding: paddingAll5, child: Text(item.name, style: kMontserrat19, textAlign: TextAlign.center)),
              Padding(
                  padding: paddingAll5,
                  child: IntrinsicHeight(
                      child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Row(children: [
                      Image.asset("assets/icon/calender.png", width: W / 18, height: W / 18, fit: BoxFit.cover),
                      SizedBox(width: W / 40),
                      Text(DateFormat("MMM d").format(item.startTime), style: kMontserrat17)
                    ]),
                    const VerticalDivider(),
                    Row(children: [
                      Image.asset("assets/icon/clock2.png", width: W / 20, height: W / 20, fit: BoxFit.cover),
                      SizedBox(width: W / 40),
                      Text(DateFormat("HH:mm").format(item.startTime), style: kMontserrat17)
                    ]),
                    const VerticalDivider(),
                    Row(children: [
                      Image.asset("assets/icon/continue.png", width: W / 20, height: W / 20, fit: BoxFit.cover),
                      SizedBox(width: W / 40),
                      Row(children: [Text("${item.duration}", style: kMontserrat17), SizedBox(width: W / 70), Text("min".tr(), style: kMontserrat17)])
                    ])
                  ]))),
              SizedBox(height: W / 60),
            ])));
  }

  String getLevelDescription(int? level) {
    String levelName = '';
    switch (level) {
      case 1:
        levelName = 'Beginner';
        break;
      case 2:
        levelName = 'Intermediate';
        break;
      case 3:
        levelName = 'Advanced';
        break;
      case 4:
        levelName = 'Expert';
        break;
      case 5:
        levelName = 'Professional';
        break;
      default:
        levelName = 'Unknown Level';
    }
    return levelName;
  }
}

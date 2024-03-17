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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: Text("Lessons".tr())),

              final today = DateTime.now();
              return SingleChildScrollView(
                  child: Container(
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
                  if (homeService.spaGroupActivity$.value == null) Center(child: CircularProgressIndicator()),
                  if (homeService.spaGroupActivity$.value!.isEmpty) Center(child: Text("no found spa group")),
                  Container(
                    height: W,
                    child: ListView.builder(
                      itemCount: homeService.spaGroupActivity$.value!.length,
                      itemBuilder: (context, index) {
                        var item = homeService.spaGroupActivity$.value?[index];
                        if (selectedDate$.value == item!.startTime)
                          return Container(
                            child: Text(item.name ?? ""),
                          );
                      },
                    ),
                  )
                ],
              )));
            }));
  }
}

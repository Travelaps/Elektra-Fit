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
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Lessons".tr()),
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.white,
              tabs: [
                Tab(child: Text('All'.tr(), style: kMontserrat18.copyWith(color: Colors.white))),
                Tab(child: Text('My Attended'.tr(), style: kMontserrat18.copyWith(color: Colors.white))),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              StreamBuilder(
                stream: homeService.spaGroupActivity$,
                builder: (context, snapshot) {
                  if (homeService.spaGroupActivity$.value == null) {
                    return Center(child: CircularProgressIndicator(color: config.primaryColor));
                  } else if (homeService.spaGroupActivity$.value!.isEmpty) {
                    return const Center(child: Text('No Data Available'));
                  }
                  return ActivityList(homeService: homeService, width: W, height: H);
                },
              ),
              StreamBuilder(
                stream: homeService.spaGroupActivityMember$,
                builder: (context, snapshot) {
                  if (homeService.spaGroupActivityMember$.value == null) {
                    return Center(child: CircularProgressIndicator(color: config.primaryColor));
                  } else if (homeService.spaGroupActivityMember$.value!.isEmpty) {
                    return Center(child: Text("You do not have any activity records yet.".tr()));
                  }

                  return MyActivity(service: homeService, width: W, height: H);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyActivity extends StatefulWidget {
  final HomeService service;
  final double width;
  final double height;

  const MyActivity({
    Key? key,
    required this.service,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  State<MyActivity> createState() => _MyActivityState();
}

class _MyActivityState extends State<MyActivity> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SpaGroupActivityMemberListModel>?>(
      stream: widget.service.spaGroupActivityMember$.stream,
      builder: (context, snapshot) {
        if (widget.service.spaGroupActivityMember$.value == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (widget.service.spaGroupActivityMember$.value!.isEmpty) {
          return Center(child: Text("You do not have any activity records yet.".tr()));
        }
        return SizedBox(
            height: widget.height * 0.9,
            child: ListView.builder(
                itemCount: widget.service.spaGroupActivityMember$.value!.length,
                itemBuilder: (context, index) {
                  var item = widget.service.spaGroupActivityMember$.value?[index];
                  if (item != null) {
                    return ActivityCard(item: item, width: widget.width);
                  } else if (item == null) Center(child: CircularProgressIndicator(color: config.primaryColor));
                  return const SizedBox();
                }));
      },
    );
  }
}

class ActivityCard extends StatelessWidget {
  final SpaGroupActivityMemberListModel item;
  final double width;

  const ActivityCard({
    Key? key,
    required this.item,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: paddingAll10,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), spreadRadius: 5, blurRadius: 10, offset: const Offset(0, 3))]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Stack(children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                imageUrl: item.photourl ?? "https://files.cdn.elektraweb.com/bdcac343/24277/images/3c96c5fb-3c3d-49d1-9ea9-9922ed6be380.png",
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(child: CircularProgressIndicator(color: config.primaryColor)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            if (item.level != null && item.level! < 6)
              Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                      ),
                      child: Row(children: [
                        Icon(Icons.star_outlined, color: getLevelDescriptionColor(item.level)),
                        SizedBox(width: width / 40),
                        Text(getLevelDescription(item.level).tr(), style: kMontserrat19.copyWith(color: Colors.white)),
                      ])))
          ]),
          Padding(
              padding: EdgeInsets.all(10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(item.name ?? '', style: kProxima19, textAlign: TextAlign.center),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Event Venue".tr(), style: kProxima17),
                    Row(
                      children: [
                        Image.asset("assets/icon/place.png", width: width / 18, height: width / 18, fit: BoxFit.cover),
                        SizedBox(width: width / 60),
                        Text("${item.placename}", style: kProxima17),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Instructor name".tr(), style: kProxima17),
                    Text("${item.trainername}", style: kProxima17),
                  ],
                ),
                const Divider(),
                IntrinsicHeight(
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  if (item.startTime != null)
                    Row(
                      children: [
                        Image.asset("assets/icon/calender.png", width: width / 18, height: width / 18, fit: BoxFit.cover),
                        SizedBox(width: width / 40),
                        Text(DateFormat("MMM d").format(item.startTime!), style: kProxima17),
                      ],
                    ),
                  if (item.startTime != null) const VerticalDivider(),
                  if (item.startTime != null)
                    Row(
                      children: [
                        Image.asset("assets/icon/clock2.png", width: width / 20, height: width / 20, fit: BoxFit.cover),
                        SizedBox(width: width / 40),
                        Text(DateFormat("HH:mm").format(item.startTime!), style: kProxima17),
                      ],
                    ),
                  if (item.duration != null) const VerticalDivider(),
                  if (item.duration != null)
                    Row(children: [
                      if (item.duration != null) Image.asset("assets/icon/continue.png", width: width / 20, height: width / 20, fit: BoxFit.cover),
                      if (item.duration != null) SizedBox(width: width / 40),
                      if (item.duration != null)
                        Row(children: [
                          Text("${item.duration}", style: kProxima17),
                          SizedBox(width: width / 70),
                          Text("min".tr(), style: kProxima17),
                        ])
                    ])
                ]))
              ]))
        ]));
  }
}

class ActivityList extends StatefulWidget {
  final HomeService homeService;
  final double width;
  final double height;

  const ActivityList({
    Key? key,
    required this.homeService,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  State<ActivityList> createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Rx.combineLatest2(widget.homeService.selectedDate$, widget.homeService.spaGroupActivity$, (a, b) => null),
      builder: (context, snapshot) {
        DateTime selectedDate = widget.homeService.selectedDate$.value;
        widget.homeService.totalFilter = widget.homeService.spaGroupActivity$.value?.where((element) {
              DateTime activityDate = DateTime(element.startTime.year, element.startTime.month, element.startTime.day);
              return activityDate.year == selectedDate.year && activityDate.month == selectedDate.month && activityDate.day == selectedDate.day;
            }).toList() ??
            [];

        return SingleChildScrollView(
          child: Column(
            children: [
              DateSelector(homeService: widget.homeService, width: widget.width),
              SizedBox(
                width: widget.width,
                height: widget.height * 0.68,
                child: widget.homeService.totalFilter.isEmpty
                    ? Center(
                        child: Text(
                          "No activities found for the selected date.".tr(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Wrap(
                          children: widget.homeService.totalFilter
                              .map((item) => SizedBox(width: widget.width, child: GroupActivityCard(item: item, width: widget.width)))
                              .toList(),
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class GroupActivityCard extends StatelessWidget {
  final SpaGroupActivityModel item;
  final double width;

  const GroupActivityCard({
    Key? key,
    required this.item,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Navigator.push(context, RouteAnimation.createRoute(SpaGroupActivityDetail(item: item), 0, 1)),
        child: Container(
            margin: marginAll8,
            width: width,
            decoration: BoxDecoration(
              borderRadius: borderRadius10,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    child: CachedNetworkImage(
                      imageUrl: item.photoUrl,
                      fit: BoxFit.cover,
                      width: width,
                      height: width / 1.9,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator(color: config.primaryColor)),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star_outlined, color: getLevelDescriptionColor(item.level)),
                          SizedBox(width: width / 40),
                          Text(getLevelDescription(item.level).tr(), style: kMontserrat19.copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    Text(item.name, style: kMontserrat19),
                    IntrinsicHeight(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset("assets/icon/calender.png", width: width / 18, height: width / 18, fit: BoxFit.cover),
                            SizedBox(width: width / 40),
                            Text(DateFormat("MMM d").format(item.startTime), style: kMontserrat17),
                          ],
                        ),
                        const VerticalDivider(),
                        Row(
                          children: [
                            Image.asset("assets/icon/clock2.png", width: width / 20, height: width / 20, fit: BoxFit.cover),
                            SizedBox(width: width / 40),
                            Text(DateFormat("HH:mm").format(item.startTime), style: kMontserrat17),
                          ],
                        ),
                        const VerticalDivider(),
                        Row(children: [
                          Image.asset("assets/icon/continue.png", width: width / 20, height: width / 20, fit: BoxFit.cover),
                          SizedBox(width: width / 40),
                          Row(children: [
                            Text("${item.duration}", style: kMontserrat17),
                            SizedBox(width: width / 70),
                            Text("min".tr(), style: kMontserrat17)
                          ])
                        ])
                      ],
                    ))
                  ]))
            ])));
  }
}

class DateSelector extends StatelessWidget {
  final HomeService homeService;
  final double width;

  const DateSelector({
    Key? key,
    required this.homeService,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    return SizedBox(
      height: width / 4,
      width: width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 30,
        itemBuilder: (BuildContext context, int index) {
          DateTime date = today.add(Duration(days: index));
          return Container(
            width: width / 5,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: homeService.selectedDate$.value.year == date.year &&
                      homeService.selectedDate$.value.month == date.month &&
                      homeService.selectedDate$.value.day == date.day
                  ? Colors.black87
                  : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: InkWell(
              onTap: () async {
                homeService.selectedDate$.add(date);
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat("EEE", Localizations.localeOf(context).languageCode).format(date).tr(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: homeService.selectedDate$.value.year == date.year &&
                                homeService.selectedDate$.value.month == date.month &&
                                homeService.selectedDate$.value.day == date.day
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        DateFormat('d', Localizations.localeOf(context).languageCode).format(date),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

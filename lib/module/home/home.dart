import 'package:flutter/material.dart';

import '../../global/global-models.dart';
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
    homeService.selectedDate$ = BehaviorSubject.seeded(DateTime.now());

    super.initState();
  }

  @override
  void dispose() {
    homeService.selectedDate$.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: Text("Lessons".tr())),
        body: StreamBuilder(
            stream: Rx.combineLatest2(homeService.selectedDate$, homeService.spaGroupActivity$, (a, b) => null),
            builder: (context, snapshot) {
              final today = DateTime.now();
              print(homeService.selectedDate$.value);
              return SingleChildScrollView(
                  child: Column(children: [
                Container(
                  height: W / 4,
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
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 3)),
                              ],
                            ),
                            child: InkWell(
                                onTap: () {
                                  homeService.selectedDate$.add(date);
                                },
                                child: Center(
                                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Text(
                                    DateFormat("EEE").format(date).tr(),
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    DateFormat('d').format(date),
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  )
                                ]))));
                      }),
                ),
                SizedBox(
                  height: H * 0.79,
                  child: ListView.builder(
                    itemCount: homeService.spaGroupActivity$.value.keys.length,
                    itemBuilder: (context, index) {
                      DateTime date = homeService.spaGroupActivity$.value.keys.elementAt(index);
                      List<SpaGroupActivityModel>? item = homeService.spaGroupActivity$.value[date];
                      return InkWell(
                        onTap: () {
                          if (item != null) {}
                        },
                        child: Container(
                          margin: marginAll10,
                          decoration: BoxDecoration(
                            color: isDarkMode$.value ? Colors.black87 : Colors.white,
                            boxShadow: [
                              BoxShadow(color: isDarkMode$.value ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.7), spreadRadius: 2, blurRadius: 5, offset: const Offset(0, 4)),
                            ],
                            borderRadius: borderRadius10,
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: borderRadius10,
                                child: CachedNetworkImage(
                                  imageUrl: item != null ? item[index]?.photoUrl ?? "" : "",
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(child: CircularProgressIndicator(color: config.primaryColor)),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                              if (item != null)
                                Positioned.fill(
                                  bottom: 0,
                                  child: Container(
                                    width: W,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                                      ),
                                      borderRadius: borderRadius10,
                                      boxShadow: [
                                        BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 3)),
                                      ],
                                    ),
                                    child: Text(item[index]?.name ?? "", style: kAxiforma20.copyWith(color: Colors.white), textAlign: TextAlign.center),
                                  ),
                                ),
                              if (item != null)
                                Positioned(
                                  child: Container(
                                    padding: paddingAll10,
                                    margin: marginAll5,
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: config.primaryColor),
                                    child: Text(item[index]?.level.toString() ?? "", style: kAxiforma19.copyWith(color: Colors.white)),
                                  ),
                                ),
                              // if (item != null)
                              // Positioned(
                              // right: 0,
                              // bottom: 0,
                              // child: Container(
                              // padding: paddingAll5,
                              // child: Text(item[index]?.duration.tr() ?? "", style: kAxiforma19.copyWith(color: Colors.white)),
                              // ),
                              // )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // // body: SingleChildScrollView(
                //   child: Column(
                //     children: [
                //       SizedBox(
                //           height: W / 4,
                //           width: W,
                //           child: StreamBuilder<DateTime>(
                //               stream: _selectedDate$,
                //               builder: (context, snapshot) {
                //                 final today = DateTime.now();
                //                 return ListView.builder(
                //                     scrollDirection: Axis.horizontal,
                //                     itemCount: 30,
                //                     itemBuilder: (BuildContext context, int index) {
                //                       DateTime date = today.add(Duration(days: index));
                //                       return Container(
                //                           width: W / 5,
                //                           margin: marginAll5,
                //                           decoration: BoxDecoration(
                //                             borderRadius: borderRadius10,
                //                             color: Colors.white,
                //                             boxShadow: [
                //                               BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 3)),
                //                             ],
                //                           ),
                //                           child: InkWell(
                //                               onTap: () {
                //                                 _selectedDate$.add(date);
                //                               },
                //                               child: Center(
                //                                   child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                //                                 Text(
                //                                   DateFormat("EEE").format(date).tr(),
                //                                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                //                                 ),
                //                                 Text(
                //                                   DateFormat('d').format(date),
                //                                   style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                //                                 )
                //                               ]))));
                //                     });
                //               })),
                // StreamBuilder(
                //     stream: homeService.spaGroupActivity$.stream,
                //     builder: (context, snapshot) {
                //       if (homeService.spaGroupActivity$.value == null) {
                //         return Center(child: CLoading());
                //       } else if (homeService.spaGroupActivity$.value!.isNotEmpty) {
                //         return SizedBox(
                //             height: H * 0.79,
                //             child: ListView.builder(
                //                 itemCount: homeService.spaGroupActivity$.value!.length,
                //                 itemBuilder: (context, index) {
                //                   var item = homeService.spaGroupActivity$.value?[index];
                //                   return InkWell(
                //                     onTap: () {
                //                       Navigator.push(context, RouteAnimation.createRoute(SpaGroupActivityDetail(item: item!), 1, 0));
                //                     },
                //                     child: Container(
                //                       margin: marginAll10,
                //                       decoration: BoxDecoration(
                //                           color: isDarkMode$.value ? Colors.black87 : Colors.white,
                //                           boxShadow: [
                //                             BoxShadow(
                //                                 color: isDarkMode$.value ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.7), spreadRadius: 2, blurRadius: 5, offset: const Offset(0, 4)),
                //                           ],
                //                           borderRadius: borderRadius10),
                //                       child: Stack(
                //                         children: [
                //                           ClipRRect(
                //                             borderRadius: borderRadius10,
                //                             child: CachedNetworkImage(
                //                               imageUrl: item?.photoUrl ?? "",
                //                               fit: BoxFit.cover,
                //                               placeholder: (context, url) => Center(child: CircularProgressIndicator(color: config.primaryColor)),
                //                               errorWidget: (context, url, error) => const Icon(Icons.error),
                //                             ),
                //                           ),
                //                           Positioned.fill(
                //                               bottom: 0,
                //                               child: Container(
                //                                 width: W,
                //                                 alignment: Alignment.center,
                //                                 decoration: BoxDecoration(
                //                                   gradient: LinearGradient(
                //                                     begin: Alignment.topCenter,
                //                                     end: Alignment.bottomCenter,
                //                                     colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                //                                   ),
                //                                   borderRadius: borderRadius10,
                //                                   boxShadow: [
                //                                     BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 3)),
                //                                   ],
                //                                 ),
                //                                 child: Text("${item?.name}", style: kAxiforma20.copyWith(color: Colors.white), textAlign: TextAlign.center),
                //                               )),
                //                           Positioned(
                //                               child: Container(
                //                             padding: paddingAll10,
                //                             margin: marginAll5,
                //                             decoration: BoxDecoration(shape: BoxShape.circle, color: config.primaryColor),
                //                             child: Text(item!.level.toString(), style: kAxiforma19.copyWith(color: Colors.white)),
                //                           )),
                //                           Positioned(
                //                               right: 0, bottom: 0, child: Container(padding: paddingAll5, child: Text("${item.duration} min".tr(), style: kAxiforma19.copyWith(color: Colors.white))))
                //                         ],
                //                       ),
                //                     ),
                //                   );
                //                 }));
                //       } else
                //         return Center(child: Text("no found Group Activity".tr()));
                //     }),
                // ],
                // ),
                // ));
              ]));
            }));
  }
}

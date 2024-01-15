import 'package:elektra_fit/global/global-variables.dart';
import 'package:elektra_fit/module/home/tranier-list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: paddingAll10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hello Kemal", style: kMontserrat20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherList()));
                            },
                            child: SizedBox(height: W / 13, width: W / 13, child: Image.asset("assets/icon/traniers.png"))),
                        InkWell(
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherList()));
                            },
                            child: SizedBox(height: W / 13, width: W / 13, child: Image.asset("assets/icon/notifications.png"))),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: marginAll10,
                height: W / 1.1,
                decoration: BoxDecoration(
                    color: isDarkMode$.value ? Colors.black87 : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode$.value ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.7),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: W,
                            height: W / 1.6,
                            child: Image.asset("assets/image/sport4.jpg", fit: BoxFit.fitHeight),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                              ),
                            ),
                            child: SizedBox(width: W, height: W / 1.6),
                          ),
                          const Positioned(
                            top: 10,
                            left: 10,
                            child: Text(
                              'Fitness',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: const Text(
                              '1 X 30',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                                Text("15 Jan", style: kProxima16),
                              ],
                            ),
                          ),
                          const VerticalDivider(width: 2, endIndent: 2, indent: 2),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(height: W / 15, width: W / 15, child: Image.asset("assets/icon/hours.png")),
                                Text("14.00", style: kProxima16),
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
                              child: Image.asset(
                                "assets/icon/continune.png",
                                fit: BoxFit.cover,
                                color: config.primaryColor,
                              ),
                            ),
                            Text(
                              "Professional Trainer",
                              style: kMontserrat18.copyWith(color: config.primaryColor),
                            )
                          ],
                        ),
                        Text(" Kemal ORAL", style: kMontserrat18)
                      ]),
                    )
                  ],
                ),
              ),
              Container(
                margin: marginAll10,
                height: W / 1.1,
                decoration: BoxDecoration(
                    color: isDarkMode$.value ? Colors.black87 : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode$.value ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.7),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: W,
                            height: W / 1.6,
                            child: Image.asset("assets/image/sport3.jpg", fit: BoxFit.cover),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                              ),
                            ),
                            child: SizedBox(width: W, height: W / 1.6),
                          ),
                          const Positioned(
                            top: 10,
                            left: 10,
                            child: Text(
                              'Treadmill',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ),
                          const Positioned(
                            bottom: 10,
                            right: 10,
                            child: Text(
                              '30 min',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                                Text("13 Jan", style: kProxima16),
                              ],
                            ),
                          ),
                          const VerticalDivider(width: 2, endIndent: 2, indent: 2),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(height: W / 15, width: W / 15, child: Image.asset("assets/icon/hours.png")),
                                Text("12.00", style: kProxima16),
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
                              child: Image.asset(
                                "assets/icon/continune.png",
                                fit: BoxFit.cover,
                                color: config.primaryColor,
                              ),
                            ),
                            Text(
                              "Professional Trainer",
                              style: kMontserrat18.copyWith(color: config.primaryColor),
                            )
                          ],
                        ),
                        Text(" Eda Yılmaz", style: kMontserrat18)
                      ]),
                    )
                  ],
                ),
              ),
              Container(
                margin: marginAll10,
                height: W / 1.1,
                decoration: BoxDecoration(
                    color: isDarkMode$.value ? Colors.black87 : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode$.value ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.7),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: W,
                            height: W / 1.6,
                            child: Image.asset("assets/image/sport6.jpg", fit: BoxFit.cover),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                              ),
                            ),
                            child: SizedBox(width: W, height: W / 1.6),
                          ),
                          const Positioned(
                            top: 10,
                            left: 10,
                            child: Text(
                              'Gym',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: const Text(
                              '1 X 30',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                                Text("17 Jan", style: kProxima16),
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
                              child: Image.asset(
                                "assets/icon/continune.png",
                                fit: BoxFit.cover,
                                color: config.primaryColor,
                              ),
                            ),
                            Text(
                              "Professional Trainer",
                              style: kMontserrat18.copyWith(color: config.primaryColor),
                            )
                          ],
                        ),
                        Text(" Hamza Alfawer", style: kMontserrat18)
                      ]),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

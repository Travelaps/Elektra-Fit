import 'package:elektra_fit/module/Qr/Qr.dart';
import 'package:elektra_fit/module/home/home.dart';
import 'package:elektra_fit/module/profile/profile.dart';
import 'package:flutter/material.dart';

import '../global/global-variables.dart';

class CTabBar extends StatefulWidget {
  const CTabBar({Key? key}) : super(key: key);

  @override
  State<CTabBar> createState() => _CTabBarState();
}

class _CTabBarState extends State<CTabBar> {
  int currentTab = 0;
  final List<Widget> screens = [
    Home(),
    Qr(),
    Profile(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home();

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      // backgroundColor: config.primaryColor,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(side: BorderSide(width: 3, color: config.primaryColor), borderRadius: BorderRadius.all(Radius.circular(100))),
        backgroundColor: config.primaryColor,
        onPressed: () {
          setState(() {
            currentScreen = const Qr();
            currentTab = 1;
          });
        },
        child: Container(height: W / 10, width: W / 10, child: Image.asset("assets/icon/qr-icon.png")),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: paddingAll10,
        height: W / 5.53,
        notchMargin: 10,
        shape: CircularNotchedRectangle(),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          MaterialButton(
            onPressed: () {
              setState(() {
                currentScreen = const Home();
                currentTab = 0;
              });
            },
            child: Column(
              children: [
                Icon(
                  Icons.home_filled,
                  color: currentTab == 0 ? config.IconPrimaryColor : Colors.black87,
                ),
                Text(
                  "Home",
                  style: TextStyle(color: currentTab == 0 ? config.IconPrimaryColor : Colors.black87, fontFamily: "Proxima", fontSize: 16),
                )
              ],
            ),
          ),
          MaterialButton(
            minWidth: W / 4,
            onPressed: () {
              setState(() {
                currentScreen = const Profile();
                currentTab = 2;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.person,
                  color: currentTab == 2 ? config.IconPrimaryColor : Colors.black87,
                ),
                Text(
                  "Profile",
                  style: TextStyle(color: currentTab == 2 ? config.IconPrimaryColor : Colors.black87, fontFamily: "Proxima", fontSize: 16),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elektra_fit/global/index.dart';
import 'package:flutter/material.dart';

class CTabBar extends StatefulWidget {
  const CTabBar({Key? key}) : super(key: key);

  @override
  State<CTabBar> createState() => _CTabBarState();
}

class _CTabBarState extends State<CTabBar> {
  int currentTab = 0;
  final List<Widget> screens = [const Home(), const Qr(), const MyOperations(), const MyPrograming(), const Profile()];
  final List<IconData> icons = [Icons.home, Icons.qr_code, Icons.add_business_outlined, Icons.list, Icons.person];

  Widget currentScreen = const Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: config.primaryColor,
            color: config.primaryColor,
            items: icons.map((icon) => Icon(icon, size: 30, color: Colors.white)).toList(),
            onTap: (index) {
              setState(() {
                currentTab = index;
              });
            }),
        body: screens[currentTab]);
  }
}

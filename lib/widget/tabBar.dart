import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elektra_fit/global/index.dart'; // Bu dosyayı kendi projenize göre ayarlayın
import 'package:flutter/material.dart';

class CTabBar extends StatefulWidget {
  const CTabBar({Key? key}) : super(key: key);

  @override
  State<CTabBar> createState() => _CTabBarState();
}

class _CTabBarState extends State<CTabBar> {
  int currentTab = 0;
  final List<Widget> screens = [const Home(), const ExerciseProgramsList(), const MyOperations(), const Qr(), const Profile()];
  final List<String> imagesAssets = [
    'assets/icon/tab-icon/yoga2.png',
    'assets/icon/tab-icon/hlater2.png',
    'assets/icon/tab-icon/calender.png',
    'assets/icon/tab-icon/qr.png',
    'assets/icon/tab-icon/profıle2.png'
  ];
  Widget currentScreen = const Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: config.primaryColor,
        color: config.primaryColor,
        items: imagesAssets
            .map(
              (icon) => Image.asset(icon, width: 30, height: 30, color: Colors.white, fit: BoxFit.contain),
            )
            .toList(),
        onTap: (index) {
          setState(() {
            currentTab = index;
            currentScreen = screens[index];
          });
        },
      ),
      body: currentScreen,
    );
  }
}

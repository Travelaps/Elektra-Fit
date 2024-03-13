import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elektra_fit/global/global-variables.dart';
import 'package:elektra_fit/module/Qr/Qr.dart';
import 'package:elektra_fit/module/home/home.dart';
import 'package:elektra_fit/module/profile/profile.dart';
import 'package:flutter/material.dart';

import '../module/my-programing/my-programing.dart';

class CTabBar extends StatefulWidget {
  const CTabBar({Key? key}) : super(key: key);

  @override
  State<CTabBar> createState() => _CTabBarState();
}

class _CTabBarState extends State<CTabBar> {
  int currentTab = 0;
  final List<Widget> screens = [const Home(), const Qr(), const MyPrograming(), const Profile()];
  final List<IconData> icons = [Icons.home, Icons.qr_code, Icons.list, Icons.person];

  Widget currentScreen = const Home();

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;

    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.white,
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

  //   return Scaffold(
  //     body: screens[currentTab],
  //     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  //     bottomNavigationBar: BottomAppBar(
  //       height: W / 5.8,
  //       notchMargin: 10,
  //       padding: paddingAll10,
  //       elevation: 0,
  //       surfaceTintColor: Colors.yellowAccent,
  //       color: Colors.black.withOpacity(0.2),
  //       shape: CircularNotchedRectangle(),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           _buildTabItem(0, "assets/icon/tab-icon/home-selected.png", "assets/icon/tab-icon/home-unselected.png", "Home"),
  //           _buildTabItem(1, "assets/icon/qr-icon.png", "assets/icon/qr-icon.png", "Qr"),
  //           _buildTabItem(2, "assets/icon/tab-icon/my-programing-selected.png", "assets/icon/tab-icon/my-programing-unselected.png", "Activity"),
  //           _buildTabItem(3, "assets/icon/tab-icon/profile-selected.png", "assets/icon/tab-icon/profile-unselected.png", "Profile"),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildTabItem(int index, String selectedImageAsset, String unselectedImageAsset, String text) {
  //   return InkWell(
  //     onTap: () {
  //       _onTabTapped(index);
  //     },
  //     child: Container(
  //       width: MediaQuery.of(context).size.width / 4.3,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Container(
  //             alignment: Alignment.center,
  //             height: MediaQuery.of(context).size.width / 29,
  //             width: MediaQuery.of(context).size.width / 20,
  //             child: Image.asset(
  //               currentTab == index ? selectedImageAsset : unselectedImageAsset,
  //               color: currentTab == index ? config.IconPrimaryColor : Colors.black87,
  //             ),
  //           ),
  //           Text(
  //             text,
  //             style: TextStyle(
  //               color: currentTab == index ? config.IconPrimaryColor : Colors.black87,
  //               fontFamily: "Proxima",
  //               fontSize: 13,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void _onTabTapped(int index) {
    setState(() {
      currentTab = index;
    });
  }
}

import 'package:elektra_fit/global/global-variables.dart';
import 'package:elektra_fit/module/Qr/Qr.dart';
import 'package:elektra_fit/module/home/home.dart';
import 'package:elektra_fit/module/profile/profile.dart';
import 'package:flutter/material.dart';

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
      body: screens[currentTab],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onTabTapped(1);
        },
        shape: const CircleBorder(),
        elevation: 5,
        backgroundColor: currentTab == 1 ? config.IconPrimaryColor : Colors.cyan,
        child: SizedBox(height: W / 9, width: W / 9, child: Image.asset("assets/icon/qr-icon.png")),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: W / 5.8,
        notchMargin: 10,
        padding: paddingAll10,
        elevation: 0,
        surfaceTintColor: Colors.yellowAccent,
        color: Colors.black.withOpacity(0.2),
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTabItem(0, "assets/icon/home-icon.png", "Home"),
            SizedBox(width: W / 9),
            _buildTabItem(2, "assets/icon/person.png", "Profile"),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(int index, String imageAssets, String text) {
    return InkWell(
      onTap: () {
        _onTabTapped(index);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.width / 15,
              width: MediaQuery.of(context).size.width / 15,
              child: Image.asset(
                imageAssets,
                color: currentTab == index ? config.IconPrimaryColor : Colors.black87,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                color: currentTab == index ? config.IconPrimaryColor : Colors.black87,
                fontFamily: "Proxima",
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   body: PageStorage(
    //     child: currentScreen,
    //     bucket: bucket,
    //   ),
    //   // backgroundColor: config.primaryColor,
    //   floatingActionButton: FloatingActionButton(
    //     shape: RoundedRectangleBorder(side: BorderSide(width: 3, color: config.primaryColor), borderRadius: BorderRadius.all(Radius.circular(100))),
    //     backgroundColor: config.primaryColor,
    //     onPressed: () {
    //       setState(() {
    //         currentScreen = const Qr();
    //         currentTab = 1;
    //       });
    //     },
    //     child: Container(height: W / 10, width: W / 10, child: Image.asset("assets/icon/qr-icon.png")),
    //   ),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    //   bottomNavigationBar: BottomAppBar(
    //     // padding: paddingAll10,
    //     height: W / 5.4,
    //     notchMargin: 10,
    //     shadowColor: Colors.cyan,
    //     shape: CircularNotchedRectangle(),
    //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    //       SizedBox(width: 2),
    //       InkWell(
    //         onTap: () {
    //           setState(() {
    //             currentScreen = const Home();
    //             currentTab = 0;
    //           });
    //         },
    //         child: Column(
    //           children: [
    //             Icon(
    //               Icons.home_filled,
    //               color: currentTab == 0 ? config.IconPrimaryColor : Colors.black87,
    //             ),
    //             Text(
    //               "Home",
    //               style: TextStyle(color: currentTab == 0 ? config.IconPrimaryColor : Colors.black87, fontFamily: "Proxima", fontSize: 16),
    //             )
    //           ],
    //         ),
    //       ),
    //       InkWell(
    //         onTap: () {
    //           setState(() {
    //             currentScreen = const Profile();
    //             currentTab = 2;
    //           });
    //         },
    //         child: Column(
    //           children: [
    //             Icon(
    //               Icons.person,
    //               color: currentTab == 2 ? config.IconPrimaryColor : Colors.black87,
    //             ),
    //             Text(
    //               "Profile",
    //               style: TextStyle(color: currentTab == 2 ? config.IconPrimaryColor : Colors.black87, fontFamily: "Proxima", fontSize: 16),
    //             )
    //           ],
    //         ),
    //       ),
    //       SizedBox(width: 2),
    //       // SizedBox(width: W / 6)
    //     ]),
    //   ),
    // );
  }

  void _onTabTapped(int index) {
    setState(() {
      currentTab = index;
    });
  }
}

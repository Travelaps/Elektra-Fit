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
        shape: const CircleBorder(side: BorderSide(color: Colors.black)),
        elevation: 5,
        backgroundColor: currentTab == 1 ? config.IconPrimaryColor : Colors.white,
        child: SizedBox(height: W / 9, width: W / 9, child: Image.asset("assets/icon/qr-icon.png", color: currentTab == 1 ? Colors.white : Colors.black)),
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
  }

  void _onTabTapped(int index) {
    setState(() {
      currentTab = index;
    });
  }
}

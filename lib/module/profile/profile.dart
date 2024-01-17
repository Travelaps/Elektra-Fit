import 'package:elektra_fit/global/global-variables.dart';
import 'package:elektra_fit/module/auth/login/login.dart';
import 'package:elektra_fit/module/profile/profile-module/edit-profile.dart';
import 'package:elektra_fit/module/profile/profile-module/member-type.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 10, right: 10, bottom: 10),
          child: Column(
            children: [
              SizedBox(
                width: W,
                height: W / 1.6,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_ios_new)),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfile(),
                                  ));
                            },
                            child: Container(
                              height: W / 18,
                              width: W / 18,
                              child: Image.asset(
                                "assets/icon/edit-icon.png",
                                color: Colors.black,
                              ),
                            )),
                      ],
                    ),
                    SizedBox(height: W / 40),
                    Container(
                      alignment: Alignment.center,
                      child: SizedBox(height: W / 3, width: W / 3, child: Image.asset("assets/image/profile-image.png")),
                    ),
                    SizedBox(height: W / 40),
                    Text("Kemal ORAL", style: kAxiforma20),
                    Text("Premium Member", style: kProxima16),
                  ],
                ),
              ),
              SizedBox(height: W / 4),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MemberType(),
                      ));
                },
                child: Container(
                  height: W / 8,
                  padding: paddingAll10,
                  margin: marginAll5,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: borderRadius10,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  width: W,
                  child: Row(
                    children: [
                      Icon(Icons.published_with_changes_sharp, color: config.IconPrimaryColor, size: 26),
                      SizedBox(width: W / 40),
                      Text("Member Type", style: kMontserrat16),
                    ],
                  ),
                ),
              ),
              SizedBox(height: W / 30),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: paddingAll10,
                  height: W / 8,
                  margin: marginAll5,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: borderRadius10,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  width: W,
                  child: Row(
                    children: [
                      Icon(Icons.language, color: config.IconPrimaryColor, size: 25),
                      SizedBox(width: W / 40),
                      Text("Language", style: kMontserrat16),
                    ],
                  ),
                ),
              ),
              SizedBox(height: W / 30),
              InkWell(
                onTap: () {},
                child: Container(
                  height: W / 8,
                  padding: paddingAll10,
                  margin: marginAll5,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: borderRadius10,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  width: W,
                  child: Row(
                    children: [
                      SizedBox(
                        height: W / 15,
                        width: W / 15,
                        child: Image.asset("assets/icon/settings.png", color: config.primaryColor),
                      ),
                      SizedBox(width: W / 40),
                      Text("Settings", style: kMontserrat16),
                    ],
                  ),
                ),
              ),
              SizedBox(height: W / 30),
              InkWell(
                onTap: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => Login(),
                      ));
                },
                child: Container(
                  height: W / 8,
                  padding: paddingAll10,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: borderRadius10,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  width: W,
                  child: Row(
                    children: [
                      Container(
                        height: W / 15,
                        width: W / 15,
                        child: Image.asset(
                          "assets/icon/exit-icon.png",
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(width: W / 40),
                      Text("Log Out", style: kMontserrat16.copyWith(color: Colors.red)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

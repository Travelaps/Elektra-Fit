import 'package:elektra_fit/global/global-variables.dart';
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
              Container(
                width: W,
                height: W / 1.6,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
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
                    ),
                    SizedBox(height: W / 40),
                    Container(
                      alignment: Alignment.center,
                      // color: Colors.yellow,
                      child: SizedBox(height: W / 3, width: W / 3, child: Image.asset("assets/image/profile-image.png")),
                    ),
                    SizedBox(height: W / 40),
                    Text("Kemal ORAL", style: kAxiforma20),
                    Text("Premium Member", style: kProxima16),
                  ],
                ),
              ),
              SizedBox(height: W / 20),
              ListTile(
                shape: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                title: Text("Member Type", style: kProxima16),
                leading: Icon(Icons.published_with_changes_sharp, color: config.IconPrimaryColor),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MemberType(),
                      ));
                },
              ),
              // SizedBox(height: W / 30),
              // ListTile(
              //   shape: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              //   title: Text("Change Mode", style: kProxima16),
              //   leading: AnimatedSwitcher(
              //     duration: Duration(seconds: 1),
              //     child: Transform.translate(
              //       offset: Offset(17, 0),
              //       child: Transform.scale(
              //         scale: 0.75,
              //         child: CupertinoSwitch(
              //           thumbColor: isDarkMode$.value == true ? Colors.black87 : Colors.white,
              //           value: isDarkMode$.value,
              //           onChanged: (value) {
              //             isDarkMode$.value = value;
              //             isDarkMode$.add(value);
              //           },
              //           activeColor: Colors.grey.shade200,
              //         ),
              //       ),
              //     ),
              //   ),
              //   onTap: () {},
              // ),
              SizedBox(height: W / 30),
              ListTile(
                shape: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                title: Text("Language", style: kProxima16),
                leading: Icon(Icons.language, color: config.IconPrimaryColor),
                onTap: () {},
              ),
              SizedBox(height: W / 30),
              ListTile(
                shape: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                title: Text("Settings", style: kProxima16),
                leading: Icon(Icons.settings, color: config.IconPrimaryColor),
                onTap: () {},
              ),
              SizedBox(height: W / 30),
              ListTile(
                shape: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                title: Text("Log Out", style: kProxima16.copyWith(color: Colors.red)),
                leading: Icon(Icons.exit_to_app, color: Colors.red),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

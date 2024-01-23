import 'package:elektra_fit/global/global-variables.dart';
import 'package:elektra_fit/module/auth/login/login.dart';
import 'package:elektra_fit/module/profile/profile-module/member-type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return StreamBuilder(
        stream: fitness$.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Profile"),
              leading: null,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: paddingAll10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: marginAll10,
                      padding: paddingAll10,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      // width: W,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: W / 40),
                          Container(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              height: W / 3,
                              width: W / 3,
                              child: ClipOval(
                                child: Image.network(
                                  fitness$.value?.first.profile?.photourl ??
                                      "https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: W / 40),
                          Text("${fitness$.value?.first.profile?.fullname ?? ""}", style: kAxiforma20),
                          Column(
                            children: fitness$.value!.map((e) {
                              return Column(
                                children: e.membership!.map((item) {
                                  return Column(
                                    children: [
                                      Text(item.membershiptype ?? "", style: kMontserrat20.copyWith(color: config.primaryColor)),
                                      Text("${DateFormat("dd-MMM-yyyy").format(item.startdate!)} - ${DateFormat("dd-MMM-yyyy").format(item.startdate!)}", style: kMontserrat20),
                                    ],
                                  );
                                }).toList(),
                              );
                            }).toList(),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.email),
                              Text(" ozkan@gmail.com", style: kMontserrat17),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.phone),
                              Text(fitness$.value?.first.profile?.phone ?? " 5468701079", style: kMontserrat17),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: W / 30),
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
        });
  }
}

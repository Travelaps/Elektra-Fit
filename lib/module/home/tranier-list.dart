import 'package:elektra_fit/global/global-variables.dart';
import 'package:flutter/material.dart';

class TeacherList extends StatefulWidget {
  const TeacherList({Key? key}) : super(key: key);

  @override
  State<TeacherList> createState() => _TeacherListState();
}

class _TeacherListState extends State<TeacherList> {
  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Member Types")),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: marginAll10,
            decoration: BoxDecoration(
              borderRadius: borderRadius10,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  // blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
                  child: SizedBox(
                      height: W / 3,
                      width: W / 3,
                      child: Image.asset(
                        "assets/image/trainer1.png",
                        fit: BoxFit.cover,
                      )),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: W / 15, width: W / 15, child: Image.asset("assets/icon/continune.png", color: config.primaryColor)),
                        Text("Professional Trainer", style: kMontserrat17.copyWith(color: config.primaryColor)),
                      ],
                    ),
                    Text(
                      " Kemal ORAL",
                      style: kMontserrat18,
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: marginAll10,
            decoration: BoxDecoration(
              borderRadius: borderRadius10,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  // blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
                  child: SizedBox(
                      height: W / 3,
                      width: W / 3,
                      child: Image.asset(
                        "assets/image/trainer1.png",
                        fit: BoxFit.cover,
                      )),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: W / 15, width: W / 15, child: Image.asset("assets/icon/continune.png", color: config.primaryColor)),
                        Text("Professional Trainer", style: kMontserrat17.copyWith(color: config.primaryColor)),
                      ],
                    ),
                    Text(
                      " Kemal ORAL",
                      style: kMontserrat18,
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: marginAll10,
            decoration: BoxDecoration(
              borderRadius: borderRadius10,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  // blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
                  child: SizedBox(
                      height: W / 3,
                      width: W / 3,
                      child: Image.asset(
                        "assets/image/trainer1.png",
                        fit: BoxFit.cover,
                      )),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: W / 15, width: W / 15, child: Image.asset("assets/icon/continune.png", color: config.primaryColor)),
                        Text("Professional Trainer", style: kMontserrat17.copyWith(color: config.primaryColor)),
                      ],
                    ),
                    Text(
                      " Kemal ORAL",
                      style: kMontserrat18,
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: marginAll10,
            decoration: BoxDecoration(
              borderRadius: borderRadius10,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  // blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
                  child: SizedBox(
                      height: W / 3,
                      width: W / 3,
                      child: Image.asset(
                        "assets/image/trainer1.png",
                        fit: BoxFit.cover,
                      )),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: W / 15, width: W / 15, child: Image.asset("assets/icon/continune.png", color: config.primaryColor)),
                        Text("Professional Trainer", style: kMontserrat17.copyWith(color: config.primaryColor)),
                      ],
                    ),
                    Text(
                      " Kemal ORAL",
                      style: kMontserrat18,
                    )
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

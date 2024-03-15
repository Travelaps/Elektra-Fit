import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elektra_fit/global/global-variables.dart';
import 'package:flutter/material.dart';

import '../home/sport-detail/sport-details.dart';

class MyPrograming extends StatefulWidget {
  const MyPrograming({Key? key}) : super(key: key);

  @override
  State<MyPrograming> createState() => _MyProgramingState();
}

class _MyProgramingState extends State<MyPrograming> {
  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("My Programing".tr())),
      body: Padding(
        padding: paddingAll10,
        child: Column(
          children: member$.value!.map((item) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SportDetails()));
              },
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: borderRadius10,
                      child: CachedNetworkImage(
                          imageUrl: member$.value?.first.program?.first.exercisephotourl ?? "https://www.skechers.com.tr/blog/wp-content/uploads/2023/03/fitnes-770x513.jpg",
                          placeholder: (context, url) => CircularProgressIndicator(color: config.primaryColor),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          fit: BoxFit.cover)),
                  Positioned.fill(
                    bottom: 0,
                    child: Container(
                        width: W / 2.18,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.4)]),
                            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 1))]),
                        child: Text('Program'.tr(), style: kAxiforma20.copyWith(color: Colors.white), textAlign: TextAlign.center)),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

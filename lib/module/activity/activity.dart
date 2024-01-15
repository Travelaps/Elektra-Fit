import 'package:elektra_fit/module/home/sport-detail/sport-details.dart';
import 'package:flutter/material.dart';

import '../../global/global-variables.dart';

class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 10),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SportDetails(),
                    ));
              },
              child: Stack(
                children: [
                  Container(
                      margin: marginAll10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.asset(
                          "assets/image/sport6.jpg",
                          fit: BoxFit.cover,
                        ),
                      )),
                  Positioned.fill(
                    bottom: 0,
                    child: Container(
                      margin: marginAll10,
                      width: W / 2.18,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.4), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 1)),
                        ],
                      ),
                      child: Text(
                        'Plan 1',
                        style: kAxiforma20.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SportDetails(),
                    ));
              },
              child: Stack(
                children: [
                  Container(
                      margin: marginAll10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.asset(
                          "assets/image/sport6.jpg",
                          fit: BoxFit.cover,
                        ),
                      )),
                  Positioned.fill(
                    bottom: 0,
                    child: Container(
                      margin: marginAll10,
                      width: W / 2.18,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.4), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 1)),
                        ],
                      ),
                      child: Text(
                        'Plan 2',
                        style: kAxiforma20.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SportDetails(),
                    ));
              },
              child: Stack(
                children: [
                  Container(
                      margin: marginAll10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.asset(
                          "assets/image/sport6.jpg",
                          fit: BoxFit.cover,
                        ),
                      )),
                  Positioned.fill(
                    bottom: 0,
                    child: Container(
                      margin: marginAll10,
                      width: W / 2.18,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.4), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 1)),
                        ],
                      ),
                      child: Text(
                        'Plan 3',
                        style: kAxiforma20.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
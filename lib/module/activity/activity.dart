import 'package:cached_network_image/cached_network_image.dart';
import 'package:elektra_fit/global/global-variables.dart';
import 'package:flutter/material.dart';

import '../home/sport-detail/sport-details.dart';

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
      appBar: AppBar(title: Text("My Programing")),
      body: Padding(
        padding: paddingAll10,
        child: Column(
          children: fitness$.value!.map((item) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SportDetails(),
                  ),
                );
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: CachedNetworkImage(
                      imageUrl: fitness$.value?.first.program?.first.exercisephotourl ?? "https://www.skechers.com.tr/blog/wp-content/uploads/2023/03/fitnes-770x513.jpg",
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
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
                        'Program',
                        style: kAxiforma20.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
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

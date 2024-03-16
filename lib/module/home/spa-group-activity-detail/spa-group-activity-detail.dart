import 'package:flutter/material.dart';

import '../../../global/global-models.dart';
<<<<<<< HEAD
=======
import '../../../global/index.dart';
>>>>>>> 1e32a95 (updated.)

class SpaGroupActivityDetail extends StatefulWidget {
  const SpaGroupActivityDetail({super.key, required this.item});

  final SpaGroupActivityModel item;

  @override
  State<SpaGroupActivityDetail> createState() => _SpaGroupActivityDetailState();
}

class _SpaGroupActivityDetailState extends State<SpaGroupActivityDetail> {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
      appBar: AppBar(title: Text("sads")),
      body: SingleChildScrollView(),
    );
  }
}
=======
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text(widget.item.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: widget.item.photoUrl,
              fit: BoxFit.cover,
              width: W,
              height: W / 1.7,
              placeholder: (context, url) => Center(child: CircularProgressIndicator(color: config.primaryColor)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Container(
              padding: paddingAll10,
              margin: marginAll10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/icon/clock.png", fit: BoxFit.cover, height: W / 20, width: W / 20),
                      SizedBox(width: W / 60),
                      Text("${widget.item.duration} Min".tr(), style: kMontserrat18),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset("assets/icon/clock.png", fit: BoxFit.cover, height: W / 20, width: W / 20),
                      SizedBox(width: W / 60),
                      Text("${widget.item.duration} Min".tr(), style: kMontserrat18),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: paddingAll10,
              margin: marginAll5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("Level", style: kProxima17),
                      Container(
                          padding: paddingAll10,
                          margin: marginAll5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black87.withOpacity(0.2),
                          ),
                          child: Text(getLevelDescription(widget.item.level).tr(), style: kMontserrat18)),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Category".tr(), style: kProxima17),
                      Container(
                          padding: paddingAll10,
                          margin: marginAll5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black87.withOpacity(0.2),
                          ),
                          child: Text(widget.item.categoriname.tr(), style: kMontserrat18)),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Place".tr(), style: kProxima17),
                      Container(
                          padding: paddingAll10,
                          margin: marginAll5,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black87.withOpacity(0.2)),
                          child: Text(widget.item.placename.tr(), style: kMontserrat18)),
                    ],
                  ),
                ],
              ),
            ),
            Text(widget.item.notes, style: kProxima17),
            Text(widget.item.trainername, style: kProxima17),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset("assets/icon/clock.png", fit: BoxFit.cover, height: W / 20, width: W / 20),
                Text("${widget.item.duration} min".tr(), style: kProxima17),
              ],
            ),
            Text("${widget.item.capacity} Adult max".tr(), style: kProxima17),
            Text(widget.item.placename.tr(), style: kProxima17),
          ],
        ),
      ),
    );
  }
}

String getLevelDescription(int? level) {
  String levelName = '';
  switch (level) {
    case 1:
      levelName = 'Beginner';
      break;
    case 2:
      levelName = 'Intermediate';
      break;
    case 3:
      levelName = 'Advanced';
      break;
    case 4:
      levelName = 'Expert';
      break;
    case 5:
      levelName = 'Professional';
      break;
    default:
      levelName = 'Unknown Level';
  }
  return levelName;
}
>>>>>>> 1e32a95 (updated.)

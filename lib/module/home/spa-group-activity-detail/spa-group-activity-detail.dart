import 'package:flutter/material.dart';

import '../../../global/global-models.dart';
import '../../../global/index.dart';

class SpaGroupActivityDetail extends StatefulWidget {
  const SpaGroupActivityDetail({super.key, required this.item});

  final SpaGroupActivityModel item;

  @override
  State<SpaGroupActivityDetail> createState() => _SpaGroupActivityDetailState();
}

class _SpaGroupActivityDetailState extends State<SpaGroupActivityDetail> {
  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(title: Text(widget.item.name)),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(padding: paddingAll5, color: Colors.black.withOpacity(0.4), child: Icon(Icons.arrow_back_ios, color: Colors.white)),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: widget.item.photoUrl,
              fit: BoxFit.cover,
              width: W,
              height: W / 1.2,
              placeholder: (context, url) => Center(child: CircularProgressIndicator(color: config.primaryColor)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Container(
              padding: paddingAll10,
              margin: marginAll5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black87.withOpacity(0.1),
              ),
              child: Row(
                children: [
                  Icon(Icons.star_outlined, color: getLevelDescriptionColor(widget.item.level)),
                  SizedBox(width: W / 20),
                  Text(getLevelDescription(widget.item.level).tr(), style: kMontserrat18),
                ],
              ),
            ),
            Container(
              padding: paddingAll10,
              margin: marginAll5,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
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
                  Row(
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
          ],
        ),
      ),
    );
  }
}

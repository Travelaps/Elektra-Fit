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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.item.photoUrl,
                  fit: BoxFit.cover,
                  width: W,
                  height: W / 1.2,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator(color: config.primaryColor)),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Positioned(
                    top: 60,
                    left: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: paddingAll5,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black.withOpacity(0.3)),
                        child: Icon(Icons.arrow_back_ios, color: Colors.white, size: W / 18),
                      ),
                    )),
                Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                        alignment: Alignment.center,
                        padding: paddingAll5,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
                        child: Text(widget.item.name ?? "", style: kAxiforma19.copyWith(color: Colors.white)))),
              ],
            ),
            Container(
              padding: paddingAll10,
              margin: marginAll5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: config.primaryColor.withOpacity(0.9),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star_outlined, color: getLevelDescriptionColor(widget.item.level)),
                      SizedBox(width: W / 20),
                      Text(getLevelDescription(widget.item.level).tr(), style: kMontserrat18.copyWith(color: Colors.white)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset("assets/icon/clock.png", fit: BoxFit.cover, height: W / 20, width: W / 20, color: Colors.white),
                      SizedBox(width: W / 40),
                      Text("${widget.item.duration} min".tr(), style: kProxima17.copyWith(color: Colors.white)),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: paddingAll10,
              margin: marginAll5,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: config.primaryColor.withOpacity(0.9)),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [Text("Category", style: kMontserrat16.copyWith(color: Colors.white)), Text(widget.item.categoriname, style: kProxima17.copyWith(color: Colors.white))],
                      ),
                    ),
                    const VerticalDivider(indent: 4, width: 2),
                    Expanded(
                      child: Column(
                        children: [Text("Place", style: kMontserrat16.copyWith(color: Colors.white)), Text(widget.item.placename, style: kProxima17.copyWith(color: Colors.white))],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(padding: paddingAll5, child: Text(widget.item.notes, style: kProxima17)),
            Row(
              children: [
                Image.asset("assets/icon/teacher.png", fit: BoxFit.cover, height: W / 20, width: W / 20, color: config.primaryColor),
                SizedBox(width: W / 60),
                Text("Professional Trainer".tr(), style: kMontserrat18),
              ],
            ),
            Padding(padding: const EdgeInsets.only(left: 25), child: Text(widget.item.trainername, style: kProxima17)),
            // Text("${widget.item.capacity} Adult max".tr(), style: kProxima17),
          ],
        ),
      ),
    );
  }
}

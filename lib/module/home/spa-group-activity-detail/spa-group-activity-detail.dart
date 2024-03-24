import 'package:elektra_fit/widget/index.dart';
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
  final homeService = GetIt.I<HomeService>();

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Column(children: [
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
                    child: SizedBox(
                        width: W / 12,
                        height: W / 12,
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black.withOpacity(0.3)),
                              child: Icon(Icons.arrow_back_ios, color: Colors.white, size: W / 18),
                            )))),
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
                  color: config.primaryColor,
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Row(
                    children: [
                      Icon(Icons.star_outlined, color: getLevelDescriptionColor(widget.item.level)),
                      SizedBox(width: W / 40),
                      Text(getLevelDescription(widget.item.level).tr(), style: kMontserrat18.copyWith(color: Colors.white)),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    Image.asset("assets/icon/clock.png", fit: BoxFit.cover, height: W / 20, width: W / 20, color: Colors.white),
                    SizedBox(width: W / 40),
                    Text("${widget.item.duration} min".tr(), style: kMontserrat18.copyWith(color: Colors.white)),
                  ])
                ])),
            Padding(padding: paddingAll10, child: Text(widget.item.notes, style: kProxima17)),
            Container(
                padding: paddingAll10,
                margin: marginAll5,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Professional Trainer".tr(), style: kProxima17), Text(widget.item.trainername, style: kProxima17)],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Activity Start Date", style: kProxima17), Text("${DateFormat("dd MMM HH:mm").format(widget.item.startTime)}", style: kProxima17)],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Place", style: kProxima17), Text(widget.item.placename, style: kProxima17)],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Category", style: kProxima17), Text(widget.item.categoriname, style: kProxima17)],
                  )
                ]))
          ])),
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom, left: 10, right: 10),
            child: CButton(
                title: "Join to Activity".tr(),
                func: () {
                  homeService.spaGroupActivityTimetableMemberInsert(widget.item.id).then((value) {
                    if (value.result) {
                      kShowBanner(BannerType.SUCCESS, value.message, context);
                    } else {
                      kShowBanner(BannerType.ERROR, value.message.tr(), context);
                    }
                  });
                },
                width: W),
          )
        ],
      ),
    );
  }
}

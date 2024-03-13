import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elektra_fit/global/global-variables.dart';
import 'package:flutter/material.dart';

class SportDetails extends StatefulWidget {
  SportDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<SportDetails> createState() => _SportDetailsState();
}

class _SportDetailsState extends State<SportDetails> {
  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: fitness$.stream,
        builder: (context, snapshot) {
          return Scaffold(
              appBar: AppBar(title: Text("My Program".tr())),
              body: SingleChildScrollView(
                child: Column(
                    children: fitness$.value!.map((e) {
                  var program = e.program;
                  return SizedBox(
                    height: H * 0.9,
                    child: ListView.builder(
                      itemCount: program!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: borderRadius10,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset: const Offset(0, 3)
                              ),
                            ],
                          ),
                          margin: marginAll10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                                    child: CachedNetworkImage(
                                      height: W / 1.4,
                                      width: W,
                                      imageUrl: program[index].exercisephotourl ?? "https://images.pexels.com/photos/841131/pexels-photo-841131.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>  Center(child: CircularProgressIndicator(color:config.primaryColor)),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    left: 0,
                                    child: Container(
                                      width: W,
                                      alignment: Alignment.center,
                                      padding: paddingAll5,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                      ),
                                      child: Text("${program[index].exercisename}", style: kMontserrat18.copyWith(color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: paddingAll5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: program[index].p!.map((item) {
                                    // bool isNotes = program.any((item) => e.item?.any((element) => element.notes != null) ?? false);
                                    bool isNotes = item.notes != null ? true : false;
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text("${item.dayoftheweek}", style: kMontserrat18.copyWith(fontSize: 22)),
                                                Icon(Icons.calendar_month_outlined),
                                              ],
                                            ),
                                            const Spacer(),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text("${item.quantity}", style: kMontserrat18),
                                                Text("X", style: kMontserrat18.copyWith(color: config.primaryColor)),
                                                Text("${item.repeatnumber}", style: kMontserrat18)
                                              ],
                                            )
                                          ],
                                        ),
                                        if (isNotes) Text(item.notes ?? "", style: kProxima17),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }).toList()),
              ));
        });
  }
}

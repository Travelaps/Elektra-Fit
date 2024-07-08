import 'package:flutter/material.dart';

import '../../../global/index.dart';

class MemberType extends StatefulWidget {
  const MemberType({Key? key}) : super(key: key);

  @override
  State<MemberType> createState() => _MemberTypeState();
}

class _MemberTypeState extends State<MemberType> {
  BehaviorSubject<bool> isOpen$ = BehaviorSubject.seeded(false);

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: Text("Member Types".tr())),
        body: Column(
          children: member$.value!.map((e) {
                return Column(
                  children: e.membership.map((item) {
                        return Container(
                            margin: marginAll10,
                            width: W,
                            padding: paddingAll10,
                            decoration: BoxDecoration(
                              borderRadius: borderRadius10,
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.6), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 3))],
                            ),
                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                              Text(item.membershiptype ?? "", style: kMontserrat20),
                              const Divider(color: Colors.black),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Text(DateFormat("dd-MMM-yyyy").format(item.contractdate!), style: kProxima17),
                                Text("${item.price.toStringAsFixed(2)} ${item.currency}", style: kProxima17),
                              ])
                            ]));
                      }).toList() ??
                      [],
                );
              }).toList() ??
              [],
        ));
  }
}

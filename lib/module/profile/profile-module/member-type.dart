import 'package:elektra_fit/global/global-variables.dart';
import 'package:elektra_fit/widget/CExpandedSection.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

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
      appBar: AppBar(title: const Text("Member Types")),
      body: StreamBuilder(
          stream: isOpen$.stream,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(children: [
                Container(
                  margin: marginAll10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        spreadRadius: 3,
                        // blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: InkWell(
                      onTap: () {
                        isOpen$.add(!isOpen$.value);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            color: Colors.green,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    height: W / 14,
                                    width: W / 14,
                                    child: Image.asset(
                                      "assets/icon/membershıp2.png",
                                      color: config.primaryColor,
                                    )),
                                // S
                                SizedBox(width: W / 30),
                                Text("Premium Member", style: kMontserrat20),
                              ],
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                isOpen$.add(!isOpen$.value);
                              },
                              child: isOpen$.value == true ? Icon(Icons.arrow_drop_down_outlined) : Icon(Icons.arrow_drop_up_outlined)),
                        ],
                      ),
                    ),
                    subtitle: ExpandedSection(
                        expand: isOpen$.value,
                        child: Container(
                          child: Text("vhjvhjhnghcfgfcgfcgfcfg"),
                        )),
                  ),
                )
              ]),
            );
          }),
    );
  }
}

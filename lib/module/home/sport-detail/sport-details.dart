import 'package:elektra_fit/global/global-variables.dart';
import 'package:flutter/material.dart';

class SportDetails extends StatefulWidget {
  const SportDetails({Key? key}) : super(key: key);

  @override
  State<SportDetails> createState() => _SportDetailsState();
}

class _SportDetailsState extends State<SportDetails> {
  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: W / 1.3,
                width: W,
                child: Image.asset(
                  "assets/image/sport6.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 50.0,
                left: 10.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: paddingAll10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Fitness", style: kMontserrat18),
                SizedBox(height: W / 30),
                Row(
                  children: [
                    Container(
                      padding: paddingAll5,
                      decoration: BoxDecoration(borderRadius: borderRadius10, border: borderAll),
                      child: Row(
                        children: [
                          SizedBox(height: W / 14, width: W / 14, child: Image.asset("assets/icon/hours.png")),
                          Text("60 min"),
                        ],
                      ),
                    ),
                    SizedBox(width: W / 30),
                    Container(
                      padding: paddingAll5,
                      decoration: BoxDecoration(borderRadius: borderRadius10, border: borderAll),
                      child: Row(
                        children: [
                          SizedBox(height: W / 14, width: W / 14, child: Image.asset("assets/icon/fire.png")),
                          Text("350 Cal"),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: W / 30),
                Container(
                  child: Text(
                    "Want your body to be healthy. Join our program with directions according to body’s goals. Increasing physical strength is the goal of strenght training. Maintain body fitness by doing physical exercise at least 2-3 times a week. ",
                    style: kProxima15,
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: marginAll5,
                        padding: paddingAll5,
                        decoration: BoxDecoration(borderRadius: borderRadius10, border: borderAll),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Image.asset("assets/image/sports-vector/img.png"),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Full Body Warm Up"),
                                Row(
                                  children: [Text("20 Exercises  |"), Text("  22 Min")],
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(Icons.navigate_next_sharp),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: marginAll5,
                        padding: paddingAll5,
                        decoration: BoxDecoration(borderRadius: borderRadius10, border: borderAll),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Image.asset("assets/image/sports-vector/img_1.png"),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Full Body Warm Up"),
                                Row(
                                  children: [Text("20 Exercises  |"), Text("  22 Min")],
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(Icons.navigate_next_sharp),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: marginAll5,
                        padding: paddingAll5,
                        decoration: BoxDecoration(borderRadius: borderRadius10, border: borderAll),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Image.asset("assets/image/sports-vector/img_2.png"),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Full Body Warm Up"),
                                Row(
                                  children: [Text("20 Exercises  |"), Text("  22 Min")],
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(Icons.navigate_next_sharp),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: marginAll5,
                        padding: paddingAll5,
                        decoration: BoxDecoration(borderRadius: borderRadius10, border: borderAll),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Image.asset("assets/image/sports-vector/img_3.png"),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Full Body Warm Up"),
                                Row(
                                  children: [Text("20 Exercises  |"), Text("  22 Min")],
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(Icons.navigate_next_sharp),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: marginAll5,
                        padding: paddingAll5,
                        decoration: BoxDecoration(borderRadius: borderRadius10, border: borderAll),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Image.asset("assets/image/sports-vector/img_4.png"),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Full Body Warm Up"),
                                Row(
                                  children: [Text("20 Exercises  |"), Text("  22 Min")],
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(Icons.navigate_next_sharp),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: marginAll5,
                        padding: paddingAll5,
                        decoration: BoxDecoration(borderRadius: borderRadius10, border: borderAll),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Image.asset("assets/image/sports-vector/img_5.png"),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Full Body Warm Up"),
                                Row(
                                  children: [Text("20 Exercises  |"), Text("  22 Min")],
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(Icons.navigate_next_sharp),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

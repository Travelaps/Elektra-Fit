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
          Container(),
        ],
      ),
    ));
  }
}

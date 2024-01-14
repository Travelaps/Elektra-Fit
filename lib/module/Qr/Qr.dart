import 'package:flutter/material.dart';

class Qr extends StatefulWidget {
  const Qr({Key? key}) : super(key: key);

  @override
  State<Qr> createState() => _QrState();
}

class _QrState extends State<Qr> {
  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 10, right: 10, bottom: 10),
          child: Column(
            children: [
              Text("Qr"),
            ],
          ),
        ),
      ),
    );
  }
}

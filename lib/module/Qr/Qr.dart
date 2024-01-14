import 'package:elektra_fit/global/global-variables.dart';
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
        child: Container(
          height: H * 0.7,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 10, right: 10, bottom: 10),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text("Scan QR Code of the device", style: kMontserrat20),
                ),
              ),
              Container(
                height: W - 40,
                width: W - 20,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  ),
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
                child: Image.asset("assets/image/qr.png", fit: BoxFit.cover),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

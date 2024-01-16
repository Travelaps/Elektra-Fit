import 'package:elektra_fit/global/global-variables.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../widget/CButton.dart';

class Qr extends StatefulWidget {
  const Qr({Key? key}) : super(key: key);

  @override
  State<Qr> createState() => _QrState();
}

class _QrState extends State<Qr> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: H,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 10, right: 10, bottom: 10),
          child: Column(
            children: [
              SizedBox(height: W / 5),
              result != null
                  ? Container(
                      height: W - 40,
                      width: W - 40,
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
                      child: QRView(
                        key: qrKey,
                        onQRViewCreated: _onQRViewCreated,
                      ),
                    )
                  : Container(
                      height: W - 40,
                      width: W - 40,
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
                      child: Image.asset(
                        "assets/image/qr.png",
                        fit: BoxFit.cover,
                      ),
                    ),
              SizedBox(height: W / 30),
              Center(
                child: (result != null) ? Text('Barcode Type: ${describeEnum(result!.format.formatName)}   Data: ${result!.code}') : Text('Scan a code', style: kMontserrat20),
              ),
              SizedBox(height: W / 30),
              CButton(title: "Starting Scanning ", func: () {}, width: W),
            ],
          ),
        ),
      ),
    );
  }
}

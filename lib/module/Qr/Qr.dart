import 'dart:io';

import 'package:elektra_fit/global/enum/banner-enum.dart';
import 'package:elektra_fit/global/global-variables.dart';
import 'package:elektra_fit/global/helper.dart';
import 'package:elektra_fit/module/Qr/Qr-service.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../widget/CButton.dart';

class Qr extends StatefulWidget {
  const Qr({Key? key}) : super(key: key);

  @override
  State<Qr> createState() => _QrState();
}

class _QrState extends State<Qr> {
  final service = QrService();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  String? placeID;
  DateTime dateTime = DateTime.now();
  int guestId = 280122;
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      Barcode localResult = scanData;
      setState(() {
        result = localResult;
        placeID = localResult.code;
      });

      print('Format: ${localResult.format}');
      print('Code: ${localResult.code}');
    });
  }

  Future<void> _startScanning() async {
    print("Start Scanning button pressed");
    if (controller != null) {
      controller!.resumeCamera();
      print("Camera resumed");
    }

    var response = await service.postQrScanner(placeID.toString(), guestId, dateTime);
    if (response.result) {
      kShowBanner(BannerType.SUCCESS, "The entrance process to the hall was completed successfully.", context);
    } else {
      kShowBanner(BannerType.SUCCESS, "The check-out process to the hall was completed successfully.", context);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scaner"),
        leading: null,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: H * 0.76,
          padding: paddingAll10,
          child: Column(
            children: [
              // result != null
              //     ?
              Container(
                height: W - 40,
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
              ),
              // : Container(
              //     height: W - 40,
              //     decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //         colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
              //       ),
              //       borderRadius: BorderRadius.circular(10),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.black.withOpacity(0.6),
              //           spreadRadius: 3,
              //           // blurRadius: 10,
              //           offset: Offset(0, 3),
              //         ),
              //       ],
              //     ),
              //     child: Image.asset("assets/image/qr.png", fit: BoxFit.cover),
              //   ),
              SizedBox(height: W / 8),
              Text('Data: ${result?.code ?? 'N/A'}'), Spacer(),
              CButton(title: "Starting Scanning ", func: _startScanning, width: W),
            ],
          ),
        ),
      ),
    );
  }
}

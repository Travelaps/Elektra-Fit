import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:elektra_fit/global/enum/banner-enum.dart';
import 'package:elektra_fit/global/global-variables.dart';
import 'package:elektra_fit/global/helper.dart';
import 'package:elektra_fit/module/Qr/Qr-service.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rxdart/rxdart.dart';

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
  DateTime now = DateTime.now();

  BehaviorSubject<String> placedID$ = BehaviorSubject.seeded("");

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    bool isQRCodeScanned = false;

    controller.scannedDataStream.listen((scanData) {
      if (!isQRCodeScanned && placedID$.value.isEmpty) {
        isQRCodeScanned = true;
        Barcode localResult = scanData;
        placedID$.add(localResult.code!);

        String formattedDate = DateFormat('yyyy-MM-dd').format(now);
        service.postQrScanner(placedID$.value, formattedDate).then((value) {
          if (value.result) {
            kShowBanner(BannerType.SUCCESS, value.message, context);
          } else {
            kShowBanner(BannerType.ERROR, value.message, context);
          }
          Future.delayed(Duration(seconds: 2), () {
            isQRCodeScanned = false;
            placedID$.add("");
          });
        });
      }
    });
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
        title: Text("QR Scanner".tr()),
        leading: null,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: H * 0.76,
          padding: paddingAll10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: W / 20),
              Text(
                "At entry and exit, please scan the QR code".tr(),
                textAlign: TextAlign.center,
                style: kMontserrat16,
              ),
              SizedBox(height: W / 20),
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
              // SizedBox(height: W / 8),
              // Text('Data: ${result?.code ?? 'N/A'}'),
              // Spacer(),
              // CButton(title: "Starting Scanning ", func: _startScanning, width: W),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../global/index.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller != null) {
        controller!.resumeCamera();
      }
    });
  }

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
            kShowBanner(BannerType.SUCCESS, value.message.tr(), context);
          } else {
            kShowBanner(BannerType.ERROR, value.message.tr(), context);
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
      appBar: AppBar(title: Text("Entrance & Exit".tr()), leading: null),
      body: SingleChildScrollView(
        child: Container(
          height: H * 0.76,
          padding: paddingAll10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: W / 20),
              Text("At entry and exit, please scan the QR code".tr(), textAlign: TextAlign.center, style: kMontserrat16),
              SizedBox(height: W / 20),
              Container(
                height: W - 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.6), spreadRadius: 3, offset: Offset(0, 3))]),
                child: QRView(key: qrKey, onQRViewCreated: _onQRViewCreated),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  var qrText = "Please wait...";

  QRViewController controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(qrText),
            ),
            AspectRatio(
              aspectRatio: 1,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onViewCreated,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((data) {
      setState(() {
        qrText = 'Success';
      });
      Get.back(result: data);
      controller.dispose();
    });
  }
}

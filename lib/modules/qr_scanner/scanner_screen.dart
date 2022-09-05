import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  PageController _myPage = PageController(initialPage: 0);

  QRViewController? controller;
  Barcode? barCode;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Future<void> reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // bottomNavigationBar: BottomAppBar(color: Colors.white, child: AppBar()),
        // backgroundColor: Colors.green,
        body: Stack(
          alignment: Alignment.center,
          children: [
            buildQrView(context),
            Positioned(bottom: 120.0, child: buildResult())
          ],
        ),
      ),
    );
  }

  Widget buildResult() {
    return Text(
      barCode != null ? 'Result : ${barCode!.code}' : 'Scan a code!',
      maxLines: 3,
      style: TextStyle(
          color: Colors.white, backgroundColor: Colors.black, fontSize: 20.0),
    );
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderRadius: 10.0,
          borderLength: 20.0,
          borderWidth: 10.0,
          cutOutSize: MediaQuery.of(context).size.width * 0.8),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barCode) {
      setState(() {
        this.barCode = barCode;
      });
    });
  }
}

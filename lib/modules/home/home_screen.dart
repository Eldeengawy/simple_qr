import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:simple_qr/modules/qr_generate/qr_generate_screen.dart';
import 'package:simple_qr/modules/qr_scanner/scanner_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  PageController _myPage = PageController(initialPage: 0);

  QRViewController? controller;
  Barcode? barCode;
  List<Widget> screens = [ScannerScreen(), QrGenerateScreen()];
  var index = 0;

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
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: Container(
              height: 75,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 30.0,
                        icon: Icon(Icons.qr_code_scanner_rounded),
                        onPressed: () {
                          setState(() {
                            index = 0;
                          });
                        },
                      ),
                      Text('Scanner')
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        iconSize: 30.0,
                        icon: Icon(Icons.qr_code_2_rounded),
                        onPressed: () {
                          setState(() {
                            index = 1;
                          });
                        },
                      ),
                      Text('Generator')
                    ],
                  )
                ],
              ),
            ),
          ),
          // bottomNavigationBar: BottomAppBar(color: Colors.white, child: AppBar()),
          // backgroundColor: Colors.green,
          body: screens[index]),
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

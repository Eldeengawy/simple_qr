import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:simple_qr/modules/constants/constants.dart';
import 'package:simple_qr/modules/qr_generate/qr_generate_screen.dart';
import 'package:simple_qr/modules/qr_scanner/scanner_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> screens = [ScannerScreen(), QrGenerateScreen()];
  var index = 0;

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
                            MyConstants.controller?.resumeCamera();
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
                          MyConstants.controller?.pauseCamera();
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
}

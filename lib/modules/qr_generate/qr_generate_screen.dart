import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class QrGenerateScreen extends StatefulWidget {
  QrGenerateScreen({super.key});

  @override
  State<QrGenerateScreen> createState() => _QrGenerateScreenState();
}

class _QrGenerateScreenState extends State<QrGenerateScreen> {
  var dataController = TextEditingController();
  var screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 45, 45, 45),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Qr Code Generator'),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                buildQrImage(dataController: dataController),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: dataController,
                  decoration: InputDecoration(
                    hintText: "Enter the data",
                    hintStyle: const TextStyle(color: Colors.grey),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(28, 255, 255, 255),
                            fixedSize: const Size(300, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        child: const Text(
                          'Generate',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          final image = await screenshotController
                              .captureFromWidget(buildQrImage(
                            dataController: dataController,
                          ));
                          if (image == null) return;
                          await saveImage(image);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 255, 255, 255),
                            fixedSize: const Size(50, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        child: Icon(
                          Icons.download,
                          color: Colors.black,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<String> saveImage(Uint8List bytes) async {
  await [Permission.storage].request();
  final time = DateTime.now()
      .toIso8601String()
      .replaceAll('.', '-')
      .replaceAll(':', '-');
  final name = 'screenshot_$time';
  final result = await ImageGallerySaver.saveImage(bytes, name: name);
  return result['filePath'];
}

class buildQrImage extends StatelessWidget {
  const buildQrImage({
    Key? key,
    required this.dataController,
  }) : super(key: key);

  final TextEditingController dataController;

  @override
  Widget build(BuildContext context) {
    return QrImage(
      backgroundColor: Colors.white,
      data: dataController.text,
      size: 200.0,
    );
  }
}

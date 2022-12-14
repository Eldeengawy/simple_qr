import 'package:flutter/material.dart';
import 'package:simple_qr/modules/home/home_screen.dart';
import 'package:simple_qr/modules/home/test.dart';
import 'package:simple_qr/modules/qr_generate/qr_generate_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

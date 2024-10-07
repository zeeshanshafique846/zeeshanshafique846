// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner_app/new_page.dart';
//import 'package:qr_code_scanner_app/Scan.dart';
//import 'package:qr_code_scanner_app/generate_qr.dart';
//import 'package:qr_code_scanner_app/history.dart';
import 'package:qr_code_scanner_app/start_screen.dart';
import 'package:qr_code_scanner_app/services/database_services.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await DatabaseHelper().initDb();
    print('DB init sucesfully');
  } catch (e) {
    print('Here we got exception $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Code Scanner App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(title: 'QR Code Scanner'),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  double height = 0;
  double width = 0;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => start()));
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.yellow.shade700,
      body: Center(
        child: FittedBox(
          // alignment: Alignment.center,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.1, bottom: height * 0.35),
                child: Center(
                  child: SizedBox(
                      width: 150,
                      height: 170,
                      child: Image.asset("assets/qr_splash_screen.png")),
                ),
              ),
              const Text(
                "QR Code Scanner App",
                style: TextStyle(
                    fontFamily: 'Font',
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code_scanner_app/generate_qr.dart';
import 'package:qr_code_scanner_app/history.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int myIndex = 0;
  List<Widget> items = [
    GenerateQr(),
    History(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(51, 51, 51, 0.84),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.yellow.shade700, blurRadius: 6, //spreadRadius: 1
            )
          ], shape: BoxShape.circle, color: Colors.yellow.shade700),
          height: 60,
          width: 60,
          child: Image.asset("assets/qr_bottom_navigation_bar.png")),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.yellow.shade700, width: 2))),
        child: BottomNavigationBar(
          // type: BottomNavigationBarType.fixed,
          // elevation: 90,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          selectedItemColor: Colors.yellow.shade700,
          unselectedItemColor: Colors.white,
          backgroundColor: Color.fromRGBO(51, 51, 51, 0.84),

          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  width: 25,
                  height: 25,
                  "assets/qr_generate_bottom_navigation_bar.png",
                  color: Colors.white,
                ),
                label: "Generate"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  width: 25,
                  height: 25,
                  "assets/qr_history_bottom_navigation_bar.png",
                  color: Colors.white,
                ),
                label: "History"),
          ],
        ),
      ),
      body: items[myIndex],
    );
  }
}

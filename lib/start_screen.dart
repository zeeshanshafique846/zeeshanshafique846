import 'package:flutter/material.dart';
import 'package:qr_code_scanner_app/home_screen.dart';

class start extends StatefulWidget {
  start({super.key});

  @override
  State<start> createState() => _startState();
}

class _startState extends State<start> {
  double height = 0;

  double width = 0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.yellow.shade700,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/qr_splash_screen.png",
              width: width * 0.4,
              height: height * 0.5,
            ),
            Container(
              height: height * 0.25,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        },
        child: Container(
          height: 233,
          decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45), topRight: Radius.circular(45))),
          child: Column(children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 15),
                child: Container(
                  width: 100,
                  child: Divider(
                    color: Colors.yellow.shade700,
                    thickness: 3.25,
                  ),
                ),
              ),
            ),
            const Text(
              "Get Started",
              style: TextStyle(
                  fontFamily: 'Font', fontSize: 25, color: Colors.white),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 75.0, right: 45, bottom: 40, top: 8),
              child: Text(
                "Go and enjoy our features for free and make your life easy with us.",
                style: TextStyle(
                    fontFamily: 'Font', fontSize: 12, color: Colors.white),
              ),
            ),
            Container(
              width: 270,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.yellow.shade700),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Let's Go",
                    style: TextStyle(
                      fontFamily: 'Font',
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 70),
                    child: const Icon(
                      Icons.arrow_forward_outlined,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            )
          ]),
        ),
      ),
    );
  }
}


//  


//
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_app/item_modal.dart';
import 'package:qr_code_scanner_app/on_click-items/business.dart';
import 'package:qr_code_scanner_app/on_click-items/contact.dart';
import 'package:qr_code_scanner_app/on_click-items/email.dart';
import 'package:qr_code_scanner_app/on_click-items/event.dart';
import 'package:qr_code_scanner_app/on_click-items/instagram.dart';
import 'package:qr_code_scanner_app/on_click-items/location.dart';
import 'package:qr_code_scanner_app/on_click-items/telephone.dart';
import 'package:qr_code_scanner_app/on_click-items/text.dart';
import 'package:qr_code_scanner_app/on_click-items/twitter.dart';
import 'package:qr_code_scanner_app/on_click-items/website.dart';
import 'package:qr_code_scanner_app/on_click-items/whatsapp.dart';
import 'package:qr_code_scanner_app/on_click-items/wifi.dart';
//import 'package:qr_code_scanner_app/start_screen.dart';

class GenerateQr extends StatefulWidget {
  const GenerateQr({super.key});
  @override
  State<GenerateQr> createState() => _GenerateQrState();
}

class _GenerateQrState extends State<GenerateQr> {
  // ignore: non_constant_identifier_names
  GlobalKey<ScaffoldState> scaffold_key = GlobalKey<ScaffoldState>();
  bool isOn = true;
  bool isOnn = false;
  double height = 0;
  double width = 0;

  List<ItemModal> items = [
    ItemModal(text: "Text", image: 'assets/text.png', child: const text()),
    ItemModal(text: "Website", image: 'assets/www.png', child: const Website()),
    ItemModal(text: "Wi-Fi", image: 'assets/wifi.png', child: const Wifi()),
    ItemModal(text: "Event", image: 'assets/Event.png', child: const Event()),
    ItemModal(
        text: "Contact", image: 'assets/Contact.png', child: const Contact()),
    ItemModal(
        text: "Business",
        image: 'assets/Bussiness.png',
        child: const Business()),
    ItemModal(
        text: "Location",
        image: 'assets/Location.png',
        child: const Location()),
    ItemModal(
        text: "WhatsApp",
        image: 'assets/WhatsApp.png',
        child: const Whatsapp()),
    ItemModal(text: "Email", image: 'assets/Email.png', child: const Email()),
    ItemModal(
        text: "Twitter", image: 'assets/Telephone.png', child: const Twitter()),
    ItemModal(
        text: "Instagram",
        image: 'assets/Instagram.png',
        child: const Instagram()),
    ItemModal(
        text: "Telephone",
        image: 'assets/Vector-4.png',
        child: const Telephone()),
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        drawer: drawerr(),
        key: scaffold_key,
        backgroundColor: const Color.fromRGBO(51, 51, 51, 0.84),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: height * 0.05, right: width * 0.05, left: width * 0.05),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Generate QR",
                      style: TextStyle(
                          fontFamily: 'Font',
                          fontSize: 21,
                          color: Colors.white),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.grey.shade800),
                      width: 35,
                      height: 35,
                      //padding: EdgeInsets.all(1),
                      child: IconButton(
                        onPressed: () {
                          scaffold_key.currentState?.openDrawer();
                        },
                        icon: Image.asset(
                          'assets/menu.png',
                          color: Colors.yellow.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Wrap(
                  spacing: 25,
                  children: [
                    ...items.map((e) {
                      return item(e.text, e.image, e.child);
                    })
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  item(String text, String icon, Widget ontap) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.02),
      child: SizedBox(
        height: 100,
        width: 90,
        child: Stack(
          alignment: Alignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ontap));
              },
              overlayColor:const WidgetStatePropertyAll(Colors.white),
              child: Container(
                padding: EdgeInsets.all(22),
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: Colors.yellow.shade700, width: 2)),
                child: Image.asset('$icon'),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: 4, right: 4, top: 1, bottom: 1),
                    width: 70,
                    // height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.yellow.shade700,
                    ),
                    child: Center(
                      child: Text(
                        "$text",
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  drawerr() {
    return Drawer(
      backgroundColor: Color.fromRGBO(51, 51, 51, 0.84),
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: height * 0.02, left: width * 0.06, right: width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.shade800),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        //size: 20,
                        color: Colors.yellow.shade700,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.05,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Settings",
                      style: TextStyle(
                          fontFamily: 'Font',
                          fontSize: 26,
                          color: Colors.yellow.shade700),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.03,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.yellow.shade700, width: 2)),
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey.shade800),
                    child: ListTile(
                        contentPadding: EdgeInsets.only(left: 12, right: 2),
                        leading: Image.asset(
                          'assets/vibrate.png',
                          color: Colors.white,
                          height: 20,
                        ),
                        title: Text(
                          "Vibrate",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        subtitle: Text(
                          "Vibration when scan is done.",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        trailing: IconButton(
                          iconSize: 33,
                          onPressed: () {
                            setState(() {
                              isOn = !isOn;
                            });
                          },
                          icon: Icon(
                            isOn
                                ? Icons.toggle_on_outlined
                                : Icons.toggle_off_outlined,
                            color: isOn ? Colors.yellow.shade700 : Colors.grey,
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.03),
                  child: Container(
                    // height: 55,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.yellow.shade700, width: 2)),
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey.shade800),
                    child: ListTile(
                        contentPadding: EdgeInsets.only(left: 12, right: 2),
                        leading: Image.asset(
                          'assets/beep.png',
                          height: 20,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Beep",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        subtitle: Text(
                          "Beep when scan is done.",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        trailing: IconButton(
                          iconSize: 33,
                          onPressed: () {
                            setState(() {
                              isOnn = !isOnn;
                            });
                          },
                          icon: Icon(
                            isOnn
                                ? Icons.toggle_on_outlined
                                : Icons.toggle_off_outlined,
                            color: isOnn ? Colors.yellow.shade700 : Colors.grey,
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Text(
                  "Support",
                  style: TextStyle(
                      fontFamily: 'Font',
                      fontSize: 26,
                      color: Colors.yellow.shade700),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.grey.shade800),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/rate.png',
                              width: 25,
                              height: 25,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rate Us",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  Text(
                                    "Your best reward to us.",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/share.png',
                              width: 25,
                              height: 25,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Share",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  Text(
                                    "Share app with others.",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/privacy_policy.png',
                              width: 25,
                              height: 25,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Privacy Policy",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  Text(
                                    "Follow our policies that benefits you.",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
  // ListTile(
  //                           leading: Image.asset(
  //                             'assets/rate.png',
  //                             height: 25,
  //                             width: 25,
  //                           ),
  //                           title: Text(
  //                             "Rate Us",
  //                             style:
  //                                 TextStyle(fontSize: 14, color: Colors.white),
  //                           ),
  //                           subtitle: Text(
  //                             "Your best reward to us.",
  //                             style:
  //                                 TextStyle(fontSize: 13, color: Colors.grey),
  //                           ),
  //                         ),
// ignore_for_file: prefer  _const_constructors

import 'package:flutter/material.dart';
import 'package:qr_code_scanner_app/drawerr.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';
//import 'qr.dart';
//import 'package:qr_code_scanner_app/start_screen.dart';

class GenerateQr extends StatefulWidget {
  const GenerateQr({super.key});
  @override
  State<GenerateQr> createState() => _GenerateQrState();
}

class _GenerateQrState extends State<GenerateQr> {
  // ignore: non_constant_identifier_names
  GlobalKey<ScaffoldState> scaffold_key = GlobalKey<ScaffoldState>();

  double height = 0;
  double width = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ItemModal> items = [
      ItemModal(
          heading: 'Text',
          image: 'assets/text.png',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppTextWidget(text_from_home2: "Text"),
                ));
          }),
      ItemModal(
          heading: "Website",
          image: 'assets/www.png',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Website(heading1: "Website"),
                ));
          }),
      ItemModal(
          heading: "Wi-Fi",
          image: 'assets/wifi.png',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Wifi(heading2: 'Wi-Fi'),
                ));
          }),
      ItemModal(
          heading: "Event",
          image: 'assets/Event.png',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Event(
                    heading3: 'Event',
                  ),
                ));
          }),
      ItemModal(
          heading: "Contact",
          image: 'assets/Contact.png',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Contact(
                    heading4: 'Contact',
                  ),
                ));
          }),
      ItemModal(
          heading: "Business",
          image: 'assets/Bussiness.png',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Business(heading5: 'Business'),
                ));
          }),
      ItemModal(
          heading: "Location",
          image: 'assets/Location.png',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Location(
                    heading6: 'Location',
                  ),
                ));
          }),
      ItemModal(
          heading: "WhatsApp",
          image: 'assets/WhatsApp.png',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Whatsapp(
                    heading6: 'WhatsApp',
                  ),
                ));
          }),
      ItemModal(
          heading: "Email",
          image: 'assets/Email.png',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Email(
                    heading8: 'Email',
                  ),
                ));
          }),
      ItemModal(
          heading: "Twitter",
          image: 'assets/Telephone.png',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Twitter(
                    heading9: 'Twitter',
                  ),
                ));
          }),
      ItemModal(
          heading: "Instagram",
          image: 'assets/Instagram.png',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Instagram(
                    heading10: 'Instagram',
                  ),
                ));
          }),
      ItemModal(
          heading: "Telephone",
          image: 'assets/Vector-4.png',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Telephone(
                    heading11: 'Telephone',
                  ),
                ));
          }),
    ];

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
                      return item(e.heading, e.image, e.onTap);
                    })
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  item(String text, String icon, Function() ontap) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.02),
      child: SizedBox(
        height: 100,
        width: 90,
        child: Stack(
          alignment: Alignment.center,
          children: [
            InkWell(
              onTap: ontap,
              overlayColor: const WidgetStatePropertyAll(Colors.white),
              child: Container(
                padding: const EdgeInsets.all(22),
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: Colors.yellow.shade700, width: 2)),
                child: Image.asset(icon),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 4, right: 4, top: 1, bottom: 1),
                    width: 70,
                    // height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.yellow.shade700,
                    ),
                    child: Center(
                      child: Text(
                        text,
                        style: const TextStyle(fontSize: 11),
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

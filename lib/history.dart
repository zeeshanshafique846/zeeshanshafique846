import 'package:flutter/material.dart';
import 'package:qr_code_scanner_app/Scan.dart';
import 'package:qr_code_scanner_app/create.dart';
//import 'package:qr_code_scanner_app/home_screen.dart';
//import 'generate_qr.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  GlobalKey<ScaffoldState> scaffold_key = GlobalKey<ScaffoldState>();

  double height = 0;
  double width = 0;
  bool isOn = true;
  bool isOnn = false;

  List<Widget> history_tabs = [Scan(), Create()];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: drawerr(),
      key: scaffold_key,
      backgroundColor: const Color.fromRGBO(51, 51, 51, 0.84),
      body: Padding(
        padding: EdgeInsets.only(
            top: height * 0.05, right: width * 0.05, left: width * 0.05),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "History",
                  style: TextStyle(
                      fontFamily: 'Font', fontSize: 22, color: Colors.white),
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
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      width: width,
                      height: height * .08,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(7)),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                            color: Color(0xffFDB623),
                            borderRadius: BorderRadius.circular(5)),
                        tabs: const [
                          Text(
                            'Scan',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Font',
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Create',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Font',
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: history_tabs,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  drawerr() {
    return Drawer(
      backgroundColor: const Color.fromRGBO(51, 51, 51, 0.84),
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

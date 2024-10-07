import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:qr_code_scanner_app/Scan.dart';
import 'package:qr_code_scanner_app/controller/history_controller.dart';
import 'package:qr_code_scanner_app/create.dart';
import 'package:qr_code_scanner_app/modals/ScanModel.dart';
import 'package:qr_code_scanner_app/services/database_services.dart';
import 'drawerr.dart';
//import 'package:qr_code_scanner_app/home_screen.dart';
//import 'generate_qr.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  // ignore: non_constant_identifier_names
  GlobalKey<ScaffoldState> scaffold_key = GlobalKey<ScaffoldState>();

  double height = 0;
  double width = 0;
  bool isOn = true;
  bool isOnn = false;

  // ignore: non_constant_identifier_names, prefer_const_constructors
  // List<Widget> history_tabs = [];
  List<HistoryModel> historyCreateList = [];
  List<HistoryModel> historyScanList = [];

  fetchData() async {
    List dataList = await DatabaseHelper().queryDatabase();
    List<HistoryModel> historyList = dataList
        .map(
          (e) => HistoryModel.fromMap(e),
        )
        .toList();

    print('check data history len >>>>>>>>> ${historyList.length}');
    for (var i = 0; i < historyList.length; i++) {
      print("dataList >>>> qr type  ${historyList[i].qrType}");
      if (historyList[i].qrType == 'create') {
        historyCreateList.add(historyList[i]);
      } else {
        historyScanList.add(historyList[i]);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  DatabaseHelper().insert(map);
    fetchData();
    // DatabaseHelper().readDataFromTable();
  }

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
                      padding: const EdgeInsets.all(5),
                      width: width,
                      height: height * .08,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(7)),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                            color: const Color(0xffFDB623),
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
                        children: [
                          Scan(),
                          Create(
                           
                          ),
                        ],
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
}

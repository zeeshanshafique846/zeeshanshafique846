import 'package:flutter/material.dart';
import 'package:qr_code_scanner_app/open_file.dart';
import 'item_modal.dart';
import 'package:intl/intl.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  double height = 0;
  double width = 0;

  List<History_items_modal> history_items = [
    History_items_modal(
      link: 'https://itunes.com',
      type: 'Data',
      dateTime: DateTime(2022, 12, 16, 21, 30),
    ),
    History_items_modal(
      link: 'https://itunes.com',
      type: 'Data',
      dateTime: DateTime(2022, 12, 16, 21, 30),
    ),
    History_items_modal(
      link: 'https://itunes.com',
      type: 'Data',
      dateTime: DateTime(2022, 12, 16, 21, 30),
    ),
    History_items_modal(
      link: 'https://itunes.com',
      type: 'Data',
      dateTime: DateTime(2022, 12, 16, 21, 30),
    ),
    History_items_modal(
      link: 'https://itunes.com',
      type: 'Data',
      dateTime: DateTime(2022, 12, 16, 21, 30),
    ),
    History_items_modal(
      link: 'https://itunes.com',
      type: 'Data',
      dateTime: DateTime(2022, 12, 16, 21, 30),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          ...history_items.map((history) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => open_file(),
                    ));
              },
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 8),
                width: width,
                //  height: 70,
                margin: EdgeInsets.only(bottom: 11),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      color: Colors.grey.shade800,
                    )
                  ],
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/qr_start_screen.png',
                      height: 35,
                      width: 35,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                history.link,
                                style: TextStyle(color: Colors.white),
                              ),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext) {
                                          return AlertDialog(
                                            actionsAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            actionsPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 15),
                                            backgroundColor:
                                                Colors.yellow.shade700,
                                            shadowColor: Colors.grey.shade800,
                                            shape: ContinuousRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            titleTextStyle: TextStyle(
                                                fontFamily: 'Font',
                                                color: Colors.white,
                                                fontSize: 30),
                                            title: Text('Are you Sure ??'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                        fontFamily: 'Font',
                                                        color: Colors.black,
                                                        fontSize: 20),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    'No',
                                                    style: TextStyle(
                                                        fontFamily: 'Font',
                                                        color: Colors.black,
                                                        fontSize: 20),
                                                  ))
                                            ],
                                          );
                                        });
                                  },
                                  icon: Image.asset(
                                    'assets/delete.png',
                                    width: 17,
                                    height: 17,
                                  ))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                history.type,
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                "${DateFormat('dd MMM yyyy').format(history.dateTime)}, ${DateFormat.jm().format(history.dateTime)} ",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names\
}

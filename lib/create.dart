// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'item_modal.dart';
import 'package:intl/intl.dart';
import 'open_file.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {

  List<History_items_modal> create_items = [
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
    //double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          ...create_items.map((history) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      // ignore: prefer_const_constructors
                      builder: (context) => open_file(),
                    ));
              },
              child: Container(
                padding:const EdgeInsets.only(left: 15, right: 15, bottom: 8),
                width: width,
                //  height: 70,
                margin:const EdgeInsets.only(bottom: 11),
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
                  const  SizedBox(
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
                                style: const TextStyle(color: Colors.white),
                              ),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        // ignore: avoid_types_as_parameter_names
                                        builder: (BuildContext) {
                                          return AlertDialog(
                                            actionsAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            actionsPadding:
                                             const   EdgeInsets.symmetric(
                                                    horizontal: 15),
                                            backgroundColor:
                                                Colors.yellow.shade700,
                                            shadowColor: Colors.grey.shade800,
                                            shape: ContinuousRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            titleTextStyle:const TextStyle(
                                                fontFamily: 'Font',
                                                color: Colors.white,
                                                fontSize: 30),
                                            title:const Text('Are you Sure ??'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {},
                                                  child: const Text(
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
                                                  child:const Text(
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
                                style:const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                "${DateFormat('dd MMM yyyy').format(history.dateTime)}, ${DateFormat.jm().format(history.dateTime)} ",
                                style:const TextStyle(color: Colors.grey),
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
}

// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_app/controller/history_controller.dart';
import 'package:qr_code_scanner_app/modals/ScanModel.dart';
import 'package:qr_code_scanner_app/services/database_services.dart';
import 'package:qr_code_scanner_app/utils/loading_widget.dart';
import 'item_modal.dart';
import 'package:intl/intl.dart';
import 'open_file.dart';

class Create extends StatefulWidget {
  const Create({super.key});
  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final _historyController = Get.put(HistoryConntroler());
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print('check list len >>>>>>>>> ${_historyController.createdList.length}');
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(
            () {
              return _historyController.isLoading.value
                  ? SizedBox(
                      height: height * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoadingWidget(),
                        ],
                      ),
                    )
                  : _historyController.createdList.isEmpty
                      ? SizedBox(
                          height: height * 0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.history,
                                size: 110,
                                color: Colors.yellow.shade700,
                              ),
                              Text('You\'ll find your history here.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.yellow.shade700,
                                      fontFamily: 'Font',
                                      fontSize: 20)),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            ..._historyController.createdList.reversed
                                .map((history) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        // ignore: prefer_const_constructors
                                        builder: (context) => open_file(
                                          history: history,
                                        ),
                                      ));
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                  ),
                                  width: width,
                                  height: 60,
                                  margin: const EdgeInsets.only(bottom: 11),
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
                                      Padding(
                                        padding: EdgeInsets.only(top: 0.0),
                                        child: Image.asset(
                                          'assets/qr_start_screen.png',
                                          height: 38,
                                          width: 38,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: 60,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      history.type == 'Text' ||
                                                              history.type ==
                                                                  'Event' ||
                                                              history.type ==
                                                                  'Location' ||
                                                              history.type ==
                                                                  'WhatsApp'
                                                          ? history.title!
                                                          : history.type ==
                                                                      'Website' ||
                                                                  history.type ==
                                                                      'Twitter' ||
                                                                  history.type ==
                                                                      'Instagram'
                                                              ? history.link!
                                                              : history.type ==
                                                                      'Wi-Fi'
                                                                  ? history
                                                                      .wifiName!
                                                                  : history.type ==
                                                                          'Contact'
                                                                      ? history
                                                                          .firstName!
                                                                      : history.type ==
                                                                              'Business'
                                                                          ? history
                                                                              .company!
                                                                          : history.type == 'Telephone'
                                                                              ? history.phone!
                                                                              : history.type == 'Email'
                                                                                  ? history.email!
                                                                                  : '',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Font'),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            // ignore: avoid_types_as_parameter_names
                                                            builder:
                                                                (BuildContext) {
                                                              return AlertDialog(
                                                                actionsAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                actionsPadding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            15),
                                                                backgroundColor:
                                                                    Colors
                                                                        .yellow
                                                                        .shade700,
                                                                shadowColor:
                                                                    Colors.grey
                                                                        .shade800,
                                                                shape: ContinuousRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            25)),
                                                                titleTextStyle: const TextStyle(
                                                                    fontFamily:
                                                                        'Font',
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        30),
                                                                title: const Text(
                                                                    'Are you Sure ??'),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                        _historyController
                                                                            .createdList
                                                                            .remove(history);
                                                                        DatabaseHelper()
                                                                            .delete(history.id!);
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'Yes',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Font',
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 20),
                                                                      )),
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'No',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Font',
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 20),
                                                                      ))
                                                                ],
                                                              );
                                                            });
                                                      },
                                                      child: Image.asset(
                                                        'assets/delete.png',
                                                        width: 18,
                                                        height: 18,
                                                      ))
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    history.type!,
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    DateFormat('dd MMM yyyy,')
                                                            .format(
                                                          DateTime.fromMillisecondsSinceEpoch(
                                                              int.parse(history
                                                                  .createdAt!)),
                                                        ) +
                                                        " " +
                                                        DateFormat.jm().format(
                                                          DateTime.fromMillisecondsSinceEpoch(
                                                              int.parse(history
                                                                  .createdAt!)),
                                                        ),
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                          ],
                        );
            },
          ),
        ],
      ),
    );
  }
}

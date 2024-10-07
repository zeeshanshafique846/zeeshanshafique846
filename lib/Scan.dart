import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_app/controller/history_controller.dart';
import 'package:qr_code_scanner_app/modals/ScanModel.dart';
import 'package:qr_code_scanner_app/open_file.dart';
import 'package:qr_code_scanner_app/services/database_services.dart';
import 'package:qr_code_scanner_app/utils/loading_widget.dart';
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
  List<HistoryModel> historyList = [];

  final _historyController = Get.put(HistoryConntroler());

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Obx(() {
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
            : _historyController.scannedList.isEmpty
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
                      ..._historyController.scannedList.reversed.map(
                        (history) {
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: width * 0.5,
                                                child: Text(
                                                  history.title!,
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
                                                                Colors.yellow
                                                                    .shade700,
                                                            shadowColor: Colors
                                                                .grey.shade800,
                                                            shape: ContinuousRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25)),
                                                            titleTextStyle:
                                                                const TextStyle(
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
                                                                        .scannedList
                                                                        .remove(
                                                                            history);
                                                                    DatabaseHelper()
                                                                        .delete(
                                                                            history.id!);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'Yes',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Font',
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            20),
                                                                  )),
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'No',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Font',
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            20),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                history.type!,
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                DateFormat('dd MMM yyyy,')
                                                        .format(
                                                      DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                              int.parse(history
                                                                  .createdAt!)),
                                                    ) +
                                                    " " +
                                                    DateFormat.jm().format(
                                                      DateTime
                                                          .fromMillisecondsSinceEpoch(
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
                        },
                      )
                    ],
                  );
      }),
    );
  }
}

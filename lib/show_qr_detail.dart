import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:qr_bar_code/code/src/code_generate.dart';
import 'package:qr_bar_code/code/src/code_type.dart';
import 'package:qr_bar_code/qr/qr.dart';
import 'package:qr_code_scanner_app/constans/app_strings.dart';
import 'package:qr_code_scanner_app/modals/ScanModel.dart';
import 'package:share_plus/share_plus.dart';

class ShowQrDetail extends StatefulWidget {
  final HistoryModel history;
  const ShowQrDetail({
    super.key,
    required this.history,
  });

  @override
  State<ShowQrDetail> createState() => _ShowQrDetailState();
}

class _ShowQrDetailState extends State<ShowQrDetail> {
  bool _expanded = false;
  @override
  void initState() {
    super.initState();
    print('check image path in qr sc >>>>>>>> ${widget.history.imageUrl}');
    // Trigger the animation after a slight delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _expanded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Image : ${widget.history.imageUrl}');
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(51, 51, 51, 0.84),
      body: Padding(
        padding: EdgeInsets.only(
            top: height * 0.06, left: width * 0.06, right: width * 0.06),
        child: Column(
          children: [
            Row(
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
                SizedBox(width: width * 0.07),
                Text(
                  "QR Code",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'Font',
                      decorationThickness: 0),
                )
              ],
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.grey.shade800),
                      child: ListTile(
                        title: Text(
                          widget.history.type!,
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Font'),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.history.title == null ||
                                    widget.history.title == ''
                                ? Container()
                                : Text(
                                    widget.history.title!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.link == null ||
                                    widget.history.link == ''
                                ? Container()
                                : Text(
                                    widget.history.link!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.wifiName == null ||
                                    widget.history.wifiName == ''
                                ? Container()
                                : Text(
                                    widget.history.wifiName!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.password == null ||
                                    widget.history.password == ''
                                ? Container()
                                : Text(
                                    widget.history.password!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.protocol == null ||
                                    widget.history.protocol == ''
                                ? Container()
                                : Text(
                                    widget.history.protocol!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.ishidden == null ||
                                    widget.history.ishidden == ''
                                ? Container()
                                : Text(
                                    widget.history.ishidden! == '0'
                                        ? "True"
                                        : 'False',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.eventName == null ||
                                    widget.history.eventName == ''
                                ? Container()
                                : Text(
                                    widget.history.eventName!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.startDateTime != null ||
                                    widget.history.startDateTime != ''
                                ? Container()
                                : Text(
                                    DateFormat('dd MMM yyyy, hh:mm a').format(
                                      DateTime.parse(
                                          widget.history.startDateTime!),
                                    ),
                                    // history.startDateTime!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.endDateTime == null ||
                                    widget.history.endDateTime == ''
                                ? Container()
                                : Text(
                                    DateFormat('dd MMM yyyy, hh:mm a').format(
                                      DateTime.parse(
                                          widget.history.endDateTime!),
                                    ),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.eventLocation == null ||
                                    widget.history.eventLocation == ''
                                ? Container()
                                : Text(
                                    widget.history.eventLocation!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.eventDescription == null ||
                                    widget.history.eventDescription == ''
                                ? Container()
                                : Text(
                                    widget.history.eventDescription!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.firstName == null ||
                                    widget.history.firstName == ''
                                ? Container()
                                : Text(
                                    widget.history.firstName!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.lastName == null ||
                                    widget.history.lastName == ''
                                ? Container()
                                : Text(
                                    widget.history.lastName!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.company == null ||
                                    widget.history.company == ''
                                ? Container()
                                : Text(
                                    widget.history.company!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.industry == null ||
                                    widget.history.industry == ''
                                ? Container()
                                : Text(
                                    widget.history.industry!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.job == null ||
                                    widget.history.job == ''
                                ? Container()
                                : Text(
                                    widget.history.job!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.phone == null ||
                                    widget.history.phone == ''
                                ? Container()
                                : Text(
                                    widget.history.phone!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.email == null ||
                                    widget.history.email == ''
                                ? Container()
                                : Text(
                                    widget.history.email!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.address == null ||
                                    widget.history.address == ''
                                ? Container()
                                : Text(
                                    widget.history.address!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.city == null ||
                                    widget.history.city == ''
                                ? Container()
                                : Text(
                                    widget.history.city!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                            widget.history.country == null ||
                                    widget.history.country == ''
                                ? Container()
                                : Text(
                                    widget.history.country!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Font',
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.08,
                    ),
                    _expanded &&
                            File("${AppStrings.imageBasPath}${widget.history.imageUrl}")
                                .existsSync()
                        ? AnimatedContainer(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            duration: const Duration(seconds: 1),
                            width: _expanded ? width * 0.55 : 0,
                            height: _expanded ? height * 0.25 : 0,
                            child: Image.file(
                              File(
                                  "${AppStrings.imageBasPath}${widget.history.imageUrl}"),
                            ))
                        : Container(),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            File("${AppStrings.imageBasPath}${widget.history.imageUrl}")
                                    .existsSync()
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.yellow.shade700),
                                    child: IconButton(
                                      onPressed: () {
                                        shareInfo();
                                      },
                                      icon: Image.asset(
                                        'assets/share.png',
                                        color: Colors.black87,
                                        height: 35,
                                        width: 35,
                                      ),
                                    ),
                                  )
                                : AnimatedContainer(
                                    width: _expanded ? width * 0.60 : 0,
                                    height: 55,
                                    duration: Duration(milliseconds: 650),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.yellow.shade700),
                                    child: GestureDetector(
                                      onTap: () {
                                        shareInfo();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/share.png',
                                            color: Colors.black87,
                                            height: 30,
                                            width: 30,
                                          ),
                                          SizedBox(
                                            width: width * .02,
                                          ),
                                          Text(
                                            'Share',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Font',
                                              fontSize: 24,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                            File("${AppStrings.imageBasPath}${widget.history.imageUrl}")
                                    .existsSync()
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: height * .01,
                                      ),
                                      Text(
                                        'Share',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font'),
                                      )
                                    ],
                                  )
                                : Container()
                          ],
                        ),
                        SizedBox(
                          width:
                              File("/${AppStrings.imageBasPath}${widget.history.imageUrl}")
                                      .existsSync()
                                  ? width * 0.1
                                  : 0,
                        ),
                        File("/${AppStrings.imageBasPath}${widget.history.imageUrl}")
                                .existsSync()
                            ? Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.yellow.shade700),
                                    child: IconButton(
                                      onPressed: () {
                                        GallerySaver.saveImage(
                                            "/${AppStrings.imageBasPath}${widget.history.imageUrl}");
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            duration: Duration(seconds: 1),
                                            content: Text(
                                                'Image Saved Successfully.'),
                                          ),
                                        );
                                      },
                                      icon: Image.asset(
                                        'assets/save.png',
                                        color: Colors.black87,
                                        height: 35,
                                        width: 35,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  Text(
                                    'Save',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Font'),
                                  )
                                ],
                              )
                            : Container(),
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
  }

  shareInfo() {
    List<String> shareData = [
      widget.history.title != '' && widget.history.title != null
          ? widget.history.title!
          : '',
      widget.history.wifiName != '' && widget.history.wifiName != null
          ? widget.history.wifiName!
          : '',
      widget.history.password != '' && widget.history.password != null
          ? widget.history.password!
          : '',
      widget.history.protocol != '' && widget.history.protocol != null
          ? widget.history.protocol!.toString()
          : '',
      widget.history.ishidden != '' && widget.history.ishidden != null
          ? widget.history.ishidden!.toString()
          : '',
      widget.history.eventName != '' && widget.history.eventName != null
          ? widget.history.eventName!
          : '',
      widget.history.startDateTime != '' && widget.history.startDateTime != null
          ? widget.history.startDateTime!
          : '',
      widget.history.endDateTime != '' && widget.history.endDateTime != null
          ? widget.history.endDateTime!
          : '',
      widget.history.eventLocation != '' && widget.history.eventLocation != null
          ? widget.history.eventLocation!
          : '',
      widget.history.eventDescription != '' &&
              widget.history.eventDescription != null
          ? widget.history.eventDescription!
          : '',
      widget.history.firstName != '' && widget.history.firstName != null
          ? widget.history.firstName!
          : '',
      widget.history.lastName != '' && widget.history.lastName != null
          ? widget.history.lastName!
          : '',
      widget.history.company != '' && widget.history.company != null
          ? widget.history.company!
          : '',
      widget.history.job != '' && widget.history.job != null
          ? widget.history.job!
          : '',
      widget.history.industry != '' && widget.history.industry != null
          ? widget.history.industry!
          : '',
      widget.history.phone != '' && widget.history.phone != null
          ? widget.history.phone!
          : '',
      widget.history.email != '' && widget.history.email != null
          ? widget.history.email!
          : '',
      widget.history.website != '' && widget.history.website != null
          ? widget.history.website!
          : '',
      widget.history.address != '' && widget.history.address != null
          ? widget.history.address!
          : '',
      widget.history.city != '' && widget.history.city != null
          ? widget.history.city!
          : '',
      widget.history.country != '' && widget.history.country != null
          ? widget.history.country!
          : '',
      widget.history.link != '' && widget.history.link != null
          ? widget.history.link!
          : '',
    ];
    List<String> share = [];
    shareData.forEach((e) {
      if (e.isNotEmpty) {
        share.add(e);
      }
    });
    if (File("/${AppStrings.imageBasPath}${widget.history.imageUrl}")
        .existsSync()) {
      Share.shareXFiles(
        [XFile("/${AppStrings.imageBasPath}${widget.history.imageUrl}")],
        text: share.join('\n'),
      );
    } else {
      Share.share(
        share.join('\n'),
      );
    }
  }
}

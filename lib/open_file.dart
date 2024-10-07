import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
//import 'package:qr_code_scanner_app/history.dart';
//import 'package:qr_code_scanner_app/start_screen.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner_app/history.dart';
import 'package:qr_code_scanner_app/modals/ScanModel.dart';
import 'package:qr_code_scanner_app/show_qr_detail.dart';
import 'package:share_plus/share_plus.dart';

class open_file extends StatelessWidget {
  final HistoryModel history;
  const open_file({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    DateTime now = DateTime.now();

    return Scaffold(
        backgroundColor: Color.fromRGBO(51, 51, 51, 0.84),
        body: Padding(
          padding: EdgeInsets.only(
              top: height * 0.06, left: width * 0.06, right: width * 0.06),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    "Result",
                    style: TextStyle(
                        color: Colors.white, fontSize: 22, fontFamily: 'Font'),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.grey.shade800),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Image.asset(
                                'assets/qr_start_screen.png',
                                height: 35,
                                width: 35,
                              ),
                              title: Text(
                                history.type!,
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'Font'),
                              ),
                              subtitle: Text(
                                DateFormat('dd MMM yyyy,').format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          int.parse(history.createdAt!)),
                                    ) +
                                    " " +
                                    DateFormat.jm().format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          int.parse(history.createdAt!)),
                                    ),
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Container(
                              width: width * 0.7,
                              child: Divider(
                                thickness: 0,
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 14.0, right: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  history.title == null || history.title == ''
                                      ? Container()
                                      : Text(
                                          history.title!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.link == null || history.link == ''
                                      ? Container()
                                      : Text(
                                          history.link!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.wifiName == null ||
                                          history.wifiName == ''
                                      ? Container()
                                      : Text(
                                          history.wifiName!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.password == null ||
                                          history.password == ''
                                      ? Container()
                                      : Text(
                                          history.password!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.protocol == null ||
                                          history.protocol == ''
                                      ? Container()
                                      : Text(
                                          history.protocol!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.ishidden == null ||
                                          history.ishidden == ''
                                      ? Container()
                                      : Text(
                                          history.ishidden! == '1'
                                              ? "True"
                                              : 'False',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.eventName == null ||
                                          history.eventName == ''
                                      ? Container()
                                      : Text(
                                          history.eventName!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.startDateTime != null ||
                                          history.startDateTime != ''
                                      ? Container()
                                      : Text(
                                          DateFormat('dd MMM yyyy, hh:mm a')
                                              .format(
                                            DateTime.parse(
                                                history.startDateTime!),
                                          ),
                                          // history.startDateTime!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.endDateTime == null ||
                                          history.endDateTime == ''
                                      ? Container()
                                      : Text(
                                          DateFormat('dd MMM yyyy, hh:mm a')
                                              .format(
                                            DateTime.parse(
                                                history.endDateTime!),
                                          ),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.eventLocation == null ||
                                          history.eventLocation == ''
                                      ? Container()
                                      : Text(
                                          history.eventLocation!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.eventDescription == null ||
                                          history.eventDescription == ''
                                      ? Container()
                                      : Text(
                                          history.eventDescription!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.firstName == null ||
                                          history.firstName == ''
                                      ? Container()
                                      : Text(
                                          history.firstName!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.lastName == null ||
                                          history.lastName == ''
                                      ? Container()
                                      : Text(
                                          history.lastName!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.company == null ||
                                          history.company == ''
                                      ? Container()
                                      : Text(
                                          history.company!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.industry == null ||
                                          history.industry == ''
                                      ? Container()
                                      : Text(
                                          history.industry!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.job == null || history.job == ''
                                      ? Container()
                                      : Text(
                                          history.job!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.phone == null || history.phone == ''
                                      ? Container()
                                      : Text(
                                          history.phone!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.email == null || history.email == ''
                                      ? Container()
                                      : Text(
                                          history.email!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.address == null ||
                                          history.address == ''
                                      ? Container()
                                      : Text(
                                          history.address!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.city == null || history.city == ''
                                      ? Container()
                                      : Text(
                                          history.city!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                  history.country == null ||
                                          history.country == ''
                                      ? Container()
                                      : Text(
                                          history.country!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.02, bottom: height * 0.02),
                              child: history.qrType == 'scan'
                                  ? Container()
                                  : GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ShowQrDetail(
                                                history: history,
                                              ),
                                            ));
                                      },
                                      child: Text(
                                        'Show QR Code',
                                        style: TextStyle(
                                            color: Colors.yellow.shade700,
                                            fontSize: 17,
                                            fontFamily: 'Font'),
                                      ),
                                    ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.yellow.shade700),
                                child: IconButton(
                                  onPressed: () {
                                    List<String> shareData = [
                                      history.title != '' &&
                                              history.title != null
                                          ? history.title!
                                          : '',
                                      history.wifiName != '' &&
                                              history.wifiName != null
                                          ? history.wifiName!
                                          : '',
                                      history.password != '' &&
                                              history.password != null
                                          ? history.password!
                                          : '',
                                      history.protocol != '' &&
                                              history.protocol != null
                                          ? history.protocol!.toString()
                                          : '',
                                      history.ishidden != '' &&
                                              history.ishidden != null
                                          ? history.ishidden!.toString()
                                          : '',
                                      history.eventName != '' &&
                                              history.eventName != null
                                          ? history.eventName!
                                          : '',
                                      history.startDateTime != '' &&
                                              history.startDateTime != null
                                          ? history.startDateTime!
                                          : '',
                                      history.endDateTime != '' &&
                                              history.endDateTime != null
                                          ? history.endDateTime!
                                          : '',
                                      history.eventLocation != '' &&
                                              history.eventLocation != null
                                          ? history.eventLocation!
                                          : '',
                                      history.eventDescription != '' &&
                                              history.eventDescription != null
                                          ? history.eventDescription!
                                          : '',
                                      history.firstName != '' &&
                                              history.firstName != null
                                          ? history.firstName!
                                          : '',
                                      history.lastName != '' &&
                                              history.lastName != null
                                          ? history.lastName!
                                          : '',
                                      history.company != '' &&
                                              history.company != null
                                          ? history.company!
                                          : '',
                                      history.job != '' && history.job != null
                                          ? history.job!
                                          : '',
                                      history.industry != '' &&
                                              history.industry != null
                                          ? history.industry!
                                          : '',
                                      history.phone != '' &&
                                              history.phone != null
                                          ? history.phone!
                                          : '',
                                      history.email != '' &&
                                              history.email != null
                                          ? history.email!
                                          : '',
                                      history.website != '' &&
                                              history.website != null
                                          ? history.website!
                                          : '',
                                      history.address != '' &&
                                              history.address != null
                                          ? history.address!
                                          : '',
                                      history.city != '' && history.city != null
                                          ? history.city!
                                          : '',
                                      history.country != '' &&
                                              history.country != null
                                          ? history.country!
                                          : '',
                                      history.link != '' && history.link != null
                                          ? history.link!
                                          : '',
                                    ];
                                    List<String> share = [];
                                    shareData.forEach((e) {
                                      if (e.isNotEmpty) {
                                        share.add(e);
                                      }
                                    });

                                    Share.share(
                                      share.join('\n'),
                                    );
                                  },
                                  icon: Image.asset(
                                    'assets/share.png',
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
                                'Share',
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'Font'),
                              )
                            ],
                          ),
                          SizedBox(
                            width: width * 0.1,
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.yellow.shade700),
                                child: IconButton(
                                  onPressed: () {
                                    List<String> shareData = [
                                      history.title != '' &&
                                              history.title != null
                                          ? history.title!
                                          : '',
                                      history.wifiName != '' &&
                                              history.wifiName != null
                                          ? history.wifiName!
                                          : '',
                                      history.password != '' &&
                                              history.password != null
                                          ? history.password!
                                          : '',
                                      history.protocol != '' &&
                                              history.protocol != null
                                          ? history.protocol!.toString()
                                          : '',
                                      history.ishidden != '' &&
                                              history.ishidden != null
                                          ? history.ishidden!.toString()
                                          : '',
                                      history.eventName != '' &&
                                              history.eventName != null
                                          ? history.eventName!
                                          : '',
                                      history.startDateTime != '' &&
                                              history.startDateTime != null
                                          ? history.startDateTime!
                                          : '',
                                      history.endDateTime != '' &&
                                              history.endDateTime != null
                                          ? history.endDateTime!
                                          : '',
                                      history.eventLocation != '' &&
                                              history.eventLocation != null
                                          ? history.eventLocation!
                                          : '',
                                      history.eventDescription != '' &&
                                              history.eventDescription != null
                                          ? history.eventDescription!
                                          : '',
                                      history.firstName != '' &&
                                              history.firstName != null
                                          ? history.firstName!
                                          : '',
                                      history.lastName != '' &&
                                              history.lastName != null
                                          ? history.lastName!
                                          : '',
                                      history.company != '' &&
                                              history.company != null
                                          ? history.company!
                                          : '',
                                      history.job != '' && history.job != null
                                          ? history.job!
                                          : '',
                                      history.industry != '' &&
                                              history.industry != null
                                          ? history.industry!
                                          : '',
                                      history.phone != '' &&
                                              history.phone != null
                                          ? history.phone!
                                          : '',
                                      history.email != '' &&
                                              history.email != null
                                          ? history.email!
                                          : '',
                                      history.website != '' &&
                                              history.website != null
                                          ? history.website!
                                          : '',
                                      history.address != '' &&
                                              history.address != null
                                          ? history.address!
                                          : '',
                                      history.city != '' && history.city != null
                                          ? history.city!
                                          : '',
                                      history.country != '' &&
                                              history.country != null
                                          ? history.country!
                                          : '',
                                      history.link != '' && history.link != null
                                          ? history.link!
                                          : '',
                                    ];
                                    List<String> share = [];
                                    shareData.forEach((e) {
                                      if (e.isNotEmpty) {
                                        share.add(e);
                                      }
                                    });
                                    Clipboard.setData(ClipboardData(
                                        text: share.join('\n').toString()));
                                    // Show a SnackBar to confirm the copy action
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text('Copied to Clipboard'),
                                      ),
                                    );
                                  },
                                  icon: Image.asset(
                                    'assets/copy.png',
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
                                'Copy',
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'Font'),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

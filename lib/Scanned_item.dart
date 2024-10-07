import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner_app/controller/history_controller.dart';
import 'package:qr_code_scanner_app/modals/ScanModel.dart';
import 'package:qr_code_scanner_app/modals/app_contact.dart';
import 'package:qr_code_scanner_app/modals/app_wifi.dart';
import 'package:qr_code_scanner_app/services/database_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:share_plus/share_plus.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:contacts_service/contacts_service.dart';
//import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:flutter_contacts/flutter_contacts.dart';

class ScannedItem extends StatefulWidget {
  final String? result;
  final String? type;
  final List<String>? data;

  ScannedItem({Key? key, this.result, this.type, this.data}) : super(key: key);

  @override
  State<ScannedItem> createState() => _ScannedItemState();
}

class _ScannedItemState extends State<ScannedItem> {
  // final Uri url = Uri.parse('');

  Future<void> _openWhatsAppChat(String phoneNumber) async {
    final Uri whatsappUri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: phoneNumber,
    );

    if (await canLaunch(whatsappUri.toString())) {
      await launch(whatsappUri.toString());
    } else {
      print('Could not launch $whatsappUri');
    }
  }

  Future<void> launch_url(String? url) async {
    if (url == null || url.isEmpty) {
      throw Exception("Invalid URL");
    }
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception("Couldn't launch $url");
    }
  }

  void _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: Uri.encodeQueryComponent(
          'subject=Hello&body=Hello, this is a test email'),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }

  void _launchPhoneDialer(String phoneNumber) async {
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      // Handle the error when the phone dialer cannot be launched
      print('Could not launch phone dialer');
    }
  }

  String isValidURL(String text) {
    final urlPattern =
        r'^(https?:\/\/)?([a-zA-Z0-9.-]+)\.([a-zA-Z]{2,6})([/\w .-]*)*\/?$';
    final instagramLinkPattern = 'https://www.instagram.com/';
    final twitterLinkPattern = 'https://www.twitter.com/';
    final phoneNumberPattern =
        r'^\+?[0-9]{1,3}?[-.\s]?[0-9]{3,5}?[-.\s]?[0-9]{4,6}[-.\s]?[0-9]{0,4}$';
    final emailPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'; // r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    //  (r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final isURL = RegExp(urlPattern, caseSensitive: false).hasMatch(text);
    final isPhoneNumber = RegExp(phoneNumberPattern).hasMatch(text);
    final isInstagramUsername = widget.result!.contains(instagramLinkPattern);
    final isTwitterUsername = widget.result!.contains(twitterLinkPattern);
    final isEmail = RegExp(emailPattern, caseSensitive: false).hasMatch(text);

    if (isPhoneNumber) {
      return 'Phone';
    } else if (isInstagramUsername) {
      return 'Instagram';
    } else if (isTwitterUsername) {
      return 'Twitter';
    } else if (isURL) {
      return 'Web';
    } else if (isEmail) {
      return 'Email';
    } else {
      return 'Invalid';
    }
  }

  final _historyController = Get.put(HistoryConntroler());

  insertData() async {
    try {
      HistoryModel row = HistoryModel(
        type: 'Text',
        qrType: 'scan',
        title: widget.result,
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      );

      final rowInserted =
          await DatabaseHelper().insert({}, history: row, imageUrl: '');
      // List<Map<String, dynamic>> rowInserted =
      //     await DatabaseHelper().queryDatabase();
      _historyController.updateHistory();
      debugPrint("Inserted Row >>>> $rowInserted");
    } catch (e) {
      debugPrint('Error to upload data  >>>>   $e');
    }
  }

  String checkLinkType = '';

  @override
  void initState() {
    super.initState();
    if (widget.result != null) {
      debugPrint('check result value by scanner >>> ${widget.result}');
      checkLinkType = isValidURL(widget.result!);
      debugPrint('check url result value >>> $checkLinkType');
      insertData();
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("type : ${widget.type}");
    // AppWifi wifi = AppWifi();
    // if (widget.type == 'Wi-Fi') {
    //   wifi.wifiName = widget.data![1].toString();
    //   debugPrint('wifi name is >>>>>>>>>> ${wifi.wifiName}');
    // }
    // if(type==null){
    //   text
    // }else{
    //   if(type==contact)
    //     {
    //       AppContact contact = widget.result as AppContact;
    //       contact.lastName
    //       contact.lastName
    //     }
    // }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(51, 51, 51, 0.84),
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
                const Text(
                  "QR Code",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Font',
                    decorationThickness: 0,
                  ),
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
                      padding: EdgeInsets.all(15),
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.grey.shade800),
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.result != null
                              ? Expanded(
                                  child: GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    widget.result!,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Font',
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 2,
                                        decorationColor: Colors.grey,
                                        fontSize: 16),
                                  ),
                                ))
                              : Container(),
                          widget.data != null
                              ? Expanded(
                                  child: widget.type == 'Event'
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ...widget.data!.map((e) {
                                              int index =
                                                  widget.data!.indexOf(e);
                                              String value = '';
                                              if (index == 2 || index == 3) {
                                                value =
                                                    "${e.split(" : ").first} : ${DateFormat('MMMM dd, yyyy').format(DateTime.parse(e.split(" : ").last))}";
                                              } else {
                                                value = e;
                                              }

                                              return value
                                                      .split(' : ')
                                                      .last
                                                      .isEmpty
                                                  ? Container()
                                                  : Text(
                                                      value.replaceAll(
                                                          '\n', ''),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Font',
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationThickness:
                                                              2,
                                                          decorationColor:
                                                              Colors.grey,
                                                          fontSize: 16),
                                                    );
                                            })
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ...widget.data!.map((e) {
                                              return e.split(' : ').last.isEmpty
                                                  ? Container()
                                                  : Text(
                                                      e.replaceAll('\n', ''),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Font',
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationThickness:
                                                              2,
                                                          decorationColor:
                                                              Colors.grey,
                                                          fontSize: 16),
                                                    );
                                            })
                                          ],
                                        ),
                                )
                              : Container(),
                          IconButton(
                            onPressed: () {
                              // Copy text to clipboard
                              Clipboard.setData(
                                  ClipboardData(text: widget.result!));
                              // Show a SnackBar to confirm the copy action
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text('Copied to Clipboard'),
                                ),
                              );
                            },
                            icon: const Icon(Icons.copy),
                            color: Colors.yellow.shade700,
                            iconSize: 21,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.08,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: height * 0.04,
                        ),
                        checkLinkType == 'Phone'
                            ? Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await ContactsService.openContactForm();
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 7.5),
                                        height: height * 0.07,
                                        width: width * 0.6,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: Colors.yellow.shade700),
                                        child: Row(
                                          children: [
                                            Icon(CupertinoIcons.add_circled),
                                            const Center(
                                              child: Text(
                                                ' Add To Contact',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Font'),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _launchPhoneDialer(widget.result!);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 7.5),
                                        height: height * 0.07,
                                        width: width * 0.6,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: Colors.yellow.shade700),
                                        child: Row(
                                          children: [
                                            Icon(Icons.call_outlined),
                                            const Center(
                                              child: Text(
                                                '  Make a Call',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Font'),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _openWhatsAppChat(widget.result!);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 7.5),
                                        height: height * 0.07,
                                        width: width * 0.6,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: Colors.yellow.shade700),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/whatsapp (3).png',
                                              width: 30,
                                              height: 30,
                                            ),
                                            const Center(
                                              child: Text(
                                                '  Chat Now',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Font'),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              )
                            : checkLinkType == 'Email'
                                ? GestureDetector(
                                    onTap: () {
                                      _launchEmail(widget.result!);
                                    },
                                    child: Container(
                                        height: height * 0.07,
                                        width: width * 0.5,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: Colors.yellow.shade700),
                                        child: const Center(
                                          child: Text(
                                            'Go To Mail',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Font'),
                                          ),
                                        )),
                                  )
                                : checkLinkType == 'Instagram'
                                    ? GestureDetector(
                                        onTap: () {
                                          if (widget.result!.contains(
                                              'https://www.instagram.com/')) {
                                            launch_url(widget.result!);
                                          }
                                        },
                                        child: Container(
                                            height: height * 0.07,
                                            width: width * 0.5,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                color: Colors.yellow.shade700),
                                            child: const Center(
                                              child: Text(
                                                'Visit Profile',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Font'),
                                              ),
                                            )),
                                      )
                                    : checkLinkType == 'Twitter'
                                        ? GestureDetector(
                                            onTap: () {
                                              if (widget.result!.contains(
                                                  'https://www.twitter.com/')) {
                                                launch_url(widget.result!);
                                              }
                                            },
                                            child: Container(
                                                height: height * 0.07,
                                                width: width * 0.5,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color:
                                                        Colors.yellow.shade700),
                                                child: const Center(
                                                  child: Text(
                                                    'Visit Profile',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontFamily: 'Font'),
                                                  ),
                                                )),
                                          )
                                        : checkLinkType == 'Web'
                                            ? GestureDetector(
                                                onTap: () {
                                                  if (widget.result!
                                                      .contains('https://')) {
                                                    launch_url(widget.result!);
                                                  } else {
                                                    launch_url(
                                                        "https://${widget.result!}");
                                                  }
                                                },
                                                child: Container(
                                                    height: height * 0.07,
                                                    width: width * 0.5,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        color: Colors
                                                            .yellow.shade700),
                                                    child: const Center(
                                                      child: Text(
                                                        'Visit Site',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontFamily: 'Font'),
                                                      ),
                                                    )),
                                              )
                                            : (widget.type == 'Event')
                                                ? GestureDetector(
                                                    onTap: () {
                                                      add_event_to_calendar(
                                                          widget.type!);
                                                    },
                                                    child: Container(
                                                        height: height * 0.07,
                                                        width: width * 0.5,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                            color: Colors.yellow
                                                                .shade700),
                                                        child: const Center(
                                                          child: Text(
                                                            'Add to Calendar',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    'Font'),
                                                          ),
                                                        )),
                                                  )
                                                : (widget.type == 'Contact')
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          add_to_contact(
                                                              widget.type!);
                                                        },
                                                        child: Container(
                                                            height:
                                                                height * 0.07,
                                                            width: width * 0.5,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7),
                                                                color: Colors
                                                                    .yellow
                                                                    .shade700),
                                                            child: const Center(
                                                              child: Text(
                                                                'Add to Contact',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontFamily:
                                                                        'Font'),
                                                              ),
                                                            )),
                                                      )
                                                    : (widget.type ==
                                                            'Business')
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              add_to_contact(
                                                                  widget.type!);
                                                            },
                                                            child: Container(
                                                                height: height *
                                                                    0.07,
                                                                width:
                                                                    width * 0.5,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                7),
                                                                    color: Colors
                                                                        .yellow
                                                                        .shade700),
                                                                child:
                                                                    const Center(
                                                                  child: Text(
                                                                    'Add to Contact',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontFamily:
                                                                            'Font'),
                                                                  ),
                                                                )),
                                                          )
                                                        : widget.type ==
                                                                'Website'
                                                            ? Text(
                                                                "Launch",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .amber),
                                                              )
                                                            : Container(),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Container(
                          width: width * 0.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.yellow.shade700),
                          child: IconButton(
                            onPressed: () {
                              if (widget.result != null) {
                                Share.share('${widget.result}');
                              } else if (widget.type == 'Event') {
                                List<String> shareList = [];
                                for (var i = 0; i < widget.data!.length; i++) {
                                  if (i == 2 || i == 3) {
                                    String value =
                                        "${widget.data![i].split(" : ").first} : ${DateFormat('MMMM dd, yyyy').format(DateTime.parse(widget.data![i].split(" : ").last))}";
                                    shareList.add(value);
                                  } else {
                                    String value = widget.data![i];
                                    shareList.add(value);
                                  }
                                }
                                shareList.removeWhere((item) {
                                  return item.split(" : ").last.isEmpty;
                                });
                                String content = '';
                                shareList.forEach((e) {
                                  content = content + "$e";
                                });
                                Share.share('${content.toString()}');
                              } else {
                                widget.data!.removeWhere((item) {
                                  return item.split(" : ").last.isEmpty;
                                });
                                String content = '';
                                widget.data!.forEach((e) {
                                  content = content + "$e";
                                });
                                Share.share('${content.toString()}');
                              }
                            },
                            icon: Image.asset(
                              'assets/share.png',
                              color: Colors.black87,
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        const Text(
                          'Share',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Font'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void add_event_to_calendar(String type) async {
    //0--> type
    //1--> event name , title
    //2 ---> start time
    //3---> end time
    //4---> eventlocation
    //5----> description
    if (type == 'Event') {
      debugPrint('event created check >>>>>>>>>>  1');
      final Event event = await Event(
        title: widget.data![1].split(" : ").last,
        description: widget.data![5].split(" : ").last,
        location: widget.data![4].split(" : ").last,
        startDate: DateTime.parse(widget.data![2]
            .split(" : ")
            .last
            .replaceAll('T', ' ')), // Start date and time
        endDate: DateTime.parse(widget.data![3]
            .split(" : ")
            .last
            .replaceAll('T', ' ')), // Start date and time
      );

      Add2Calendar.addEvent2Cal(event);
    }
  }

  Future<void> add_to_contact(String type) async {
    if (type == 'Contact') {
      // Request permission to access contacts
      if (await Permission.contacts.request().isGranted) {
        // Create a contact object
        Contact newContact = Contact(
          givenName: widget.data![1].split(' : ').last,
          middleName: widget.data![2].split(' : ').last,
          displayName:
              "${widget.data![1]} ${widget.data![2].split(' : ').last}",
          company: widget.data![3].split(' : ').last,
          jobTitle: widget.data![4].split(' : ').last,
          phones: [
            Item(label: "mobile", value: widget.data![5].split(' : ').last)
          ],
          emails: [
            Item(label: "work", value: widget.data![6].split(' : ').last)
          ],
          postalAddresses: [
            PostalAddress(
                region: widget.data![7].split(' : ').last,
                country: widget.data![9].split(' : ').last,
                city: widget.data![8].split(' : ').last)
          ],
        );

        // Save the contact
        try {
          await ContactsService.addContact(newContact);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Contact saved successfully!')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save contact: $e')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permission to access contacts was denied')),
        );
      }
    }

    if (type == 'Business') {
      // Request permission to access contacts
      if (await Permission.contacts.request().isGranted) {
        // Create a contact object
        Contact newContact = Contact(
          givenName: widget.data![1].split(' : ').last,
          // middleName: widget.data![2].split(' : ').last,
          displayName: widget.data![1],
          company: widget.data![2].split(' : ').last,
          //jobTitle: widget.data![4].split(' : ').last,
          phones: [
            Item(label: "mobile", value: widget.data![3].split(' : ').last)
          ],
          emails: [
            Item(label: "work", value: widget.data![4].split(' : ').last)
          ],
          postalAddresses: [
            PostalAddress(
                region: widget.data![5].split(' : ').last,
                country: widget.data![7].split(' : ').last,
                city: widget.data![6].split(' : ').last)
          ],
        );

        // Save the contact
        try {
          await ContactsService.addContact(newContact);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Contact saved successfully!')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save contact: $e')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permission to access contacts was denied')),
        );
      }
    }
  }
}

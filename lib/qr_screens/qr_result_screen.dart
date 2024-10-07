import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_bar_code/code/src/code_generate.dart';
import 'package:qr_bar_code/code/src/code_type.dart';
import 'package:qr_bar_code/qr/qr.dart';
import 'package:qr_code_scanner_app/controller/history_controller.dart';
import 'package:qr_code_scanner_app/modals/ScanModel.dart';
import 'package:qr_code_scanner_app/modals/app-event.dart';
import 'package:qr_code_scanner_app/modals/app_business.dart';
import 'package:qr_code_scanner_app/modals/app_contact.dart';
import 'package:qr_code_scanner_app/modals/app_singletexts.dart';
import 'package:qr_code_scanner_app/modals/app_wifi.dart';
import 'package:qr_code_scanner_app/on_click-items/text.dart';
import 'package:qr_code_scanner_app/services/database_services.dart';
import 'package:qr_code_scanner_app/utils/image_services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';

class QrScreen extends StatefulWidget {
  final String type;
  final String? text;
  final List<String>? dataList;
  final HistoryModel? history;
  const QrScreen({
    super.key,
    required this.type,
    this.dataList,
    this.text,
    this.history,
  });

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  late AppSingletexts appTexts;
  late AppWifi appWifi;
  late AppEvent appEvent;
  late AppContact appContact;
  late AppBusiness appBusiness;

  String qrString = '';

  bool _expanded = false;
  ScreenshotController screenshotController = ScreenshotController();

  Future<void> _captureAndShareQRCode() async {
    try {
      // Capture the QR code as an image
      final Uint8List? image = await screenshotController.capture();
      if (image == null) return;

      // Save the image to a temporary file
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/qr_code.png';
      final file = File(filePath);
      await file.writeAsBytes(image);

      // Share the image
      await Share.shareXFiles([XFile(filePath)], text: 'Here is your QR code!');
    } catch (e) {
      print('Error capturing and sharing QR code: $e');
    }
  }

  //---------------------------------

  Future<String?> getDownloadsFolderPath() async {
    try {
      if (Platform.isAndroid) {
        // On Android, the Downloads folder can be accessed through the external storage directory
        Directory? downloadsDirectory = await getExternalStorageDirectory();
        if (downloadsDirectory != null) {
          String downloadPath_ =
              downloadsDirectory.path.split("/Android/").first;
          String downloadsPath = "${downloadPath_}/Downloads";
          // Ensure the directory exists
          if (await Directory(downloadsPath).exists()) {
            return downloadsPath;
          } else {
            // If the Download directory doesn't exist, create it
            await Directory(downloadsPath).create(recursive: true);
            return downloadsPath;
          }
        }
        print('flu  $getDownloadsFolderPath()');
      } else if (Platform.isIOS) {
        // On iOS, the Downloads folder is within the app's Documents directory
        Directory downloadsDirectory = await getApplicationDocumentsDirectory();
        String downloadsPath = "${downloadsDirectory.path}/Downloads";
        // Ensure the directory exists
        print("check downnload path >>>> $downloadsPath");
        if (await Directory(downloadsPath).exists()) {
          return downloadsPath;
        } else {
          // If the Downloads directory doesn't exist, create it
          await Directory(downloadsPath).create(recursive: true);
          return downloadsPath;
        }
      }
    } catch (e) {
      print("Failed to get downloads folder path: $e");
    }
    return null;
  }

  Future<void> saveImage() async {
    // Request storage permission
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if (Platform.isAndroid && await Permission.manageExternalStorage.isDenied) {
      await Permission.manageExternalStorage.request();
    }

    try {
      // Capture the screenshot
      final Uint8List? image = await screenshotController.capture();
      if (image == null) {
        print('Failed to capture image');
        return;
      }

      // return ;

      String? directoryPath = await getDownloadsFolderPath();
      if (directoryPath == null) {
        //show error
        return;
      }
      print("get gallery directory $directoryPath");

      final filePath =
          '${directoryPath}/${DateTime.now()..millisecondsSinceEpoch}.png';

      final file = await File(filePath).create();
      // Write the image to file
      print("file path  $file");

      await file.writeAsBytes(image);
      GallerySaver.saveImage(file.path, albumName: 'Download');

      print('Image saved to Downloads folder: $filePath');
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  updateQrString() {
    if (widget.type == 'Text' ||
        widget.type == 'Location' ||
        widget.type == 'WhatsApp' ||
        widget.type == 'Email' ||
        widget.type == 'Telephone') {
      qrString = """${appTexts.text}""";
    } else if (widget.type == 'Website') {
      qrString = """${appTexts.text}""";
    } else if (widget.type == 'Instagram') {
      qrString = """https://www.instagram.com/${appTexts.text}""";
    } else if (widget.type == 'Twitter') {
      qrString = """https://www.twitter.com/${appTexts.text}""";
    } else if (widget.type == 'Wi-Fi') {
      qrString =
          """BEGIN : ${appWifi.type},,\nWi-Fi Name : ${appWifi.wifiName},,\nPassword : ${appWifi.password},,\nSecurity : ${appWifi.security},,\nHidden : ${appWifi.hidden}""";
    } else if (widget.type == 'Event') {
      qrString =
          """BEGIN : ${appEvent.type},,\nEvent Name : ${appEvent.eventName},,\nStart Date and Time : ${appEvent.startTime},,\nEnd Date and Time : ${appEvent.endtime},,\nEventLocation : ${appEvent.eventLocation},,\nDescription : ${appEvent.description}""";
    } else if (widget.type == 'Contact') {
      qrString =
          """BEGIN : ${appContact.type},,\nFirst Name : ${appContact.firstName},,\nLast Name : ${appContact.lastName},,\nCompany : ${appContact.company},,\nJob : ${appContact.job},,\nPhone : ${appContact.phone},,\nEmail : ${appContact.email},,\nAddress : ${appContact.address},,\nCity : ${appContact.city},,\nCountry : ${appContact.country}""";
    } else if (widget.type == 'Business') {
      qrString =
          """BEGIN : ${appBusiness.type},,\nCompany Name : ${appBusiness.companyName},,\nIndustry : ${appBusiness.industry},,\nPhone : ${appBusiness.phone},,\nEmail : ${appBusiness.email},,\nWebsite : ${appBusiness.website},,\nAddress : ${appBusiness.address},,\nCity : ${appBusiness.city},,\nCountry : ${appBusiness.country}""";
    }
    setState(() {});
  }

  updateObjects() {
    if (widget.text != null) {
      appTexts = AppSingletexts(type: widget.type, text: widget.text!);
    }
    if (widget.dataList != null) {
      if (widget.type == 'Wi-Fi') {
        appWifi = AppWifi(
            type: widget.type,
            wifiName: widget.dataList![0],
            password: widget.dataList![1],
            security: widget.dataList![2],
            hidden: widget.dataList![3]);
      }
      if (widget.type == 'Event') {
        appEvent = AppEvent(
          type: widget.type,
          eventName: widget.dataList![0],
          startTime: widget.dataList![1],
          endtime: widget.dataList![2],
          eventLocation: widget.dataList![3],
          description: widget.dataList![4],
        );
      }

      if (widget.type == 'Contact') {
        appContact = AppContact(
            type: widget.type,
            firstName: widget.dataList![0],
            lastName: widget.dataList![1],
            company: widget.dataList![2],
            job: widget.dataList![3],
            phone: widget.dataList![4],
            email: widget.dataList![5],
            address: widget.dataList![6],
            city: widget.dataList![7],
            country: widget.dataList![8]);
      }

      if (widget.type == "Business") {
        appBusiness = AppBusiness(
            type: widget.type,
            companyName: widget.dataList![0],
            industry: widget.dataList![1],
            phone: widget.dataList![2],
            email: widget.dataList![3],
            website: widget.dataList![4],
            address: widget.dataList![5],
            city: widget.dataList![6],
            country: widget.dataList![7]);
      }
    }
    setState(() {});
  }

  // Future<void> _saveToDatabase(String filePath) async {
  //   Database db = await openDatabase(
  //     join(await getDatabasesPath(), 'code_db.db'),
  //     version: 1,
  //   );

  //   await db.insert('qr_history_table', {
  //     'image_url': filePath,
  //   });
  // }

  final _historyController = Get.put(HistoryConntroler());

  insertQrResultToDb() async {
    try {
      // final status = await Permission.storage.request();
      // if (!status.isGranted) {
      //   print('Permission denied');
      //   return;
      // }

      // Get the directory where you want to create the new folder
      final Directory appDocDir = await getApplicationDocumentsDirectory();

      // Define the new directory path
      final Directory newDir = Directory('${appDocDir.path}/qr_code');

      print('check new path >>>>>>>>>. ${newDir.path}');

      // Check if the directory exists, if not, create it
      if (await newDir.exists()) {
        print('Directory already exists');
      } else {
        final createdDir = await newDir.create(recursive: true);
        print('Directory created: ${createdDir.path}');
      }

      // Capture the screenshot
      final Uint8List? image = await screenshotController.capture();
      if (image == null) {
        print('Failed to capture image');
        return;
      }
      final directory = newDir;

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final filePath =
          '${directory.path}/${widget.type}${DateTime.now()..millisecondsSinceEpoch}.png';
      print(" $filePath");
      final file = await File(filePath).create();

      await file.writeAsBytes(image);

      // print('file path >>>>>>>> ${file.path.toString().split('/').last}');
      await DatabaseHelper().insert(
        {},
        history: widget.history,
        imageUrl: file.path.toString().split('/').last,
        // imageUrl: ''
      );
      _historyController.updateHistory();
    } catch (e) {
      debugPrint('error to save data >>>>>>>>>>> $e');
    }
  }

  @override
  void initState() {
    super.initState();

    // Trigger the animation after a slight delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _expanded = true;
      });
    });

    updateObjects();
    updateQrString();
    Future.delayed(Duration(seconds: 2), () {
      insertQrResultToDb();
    });
    //debugPrint('check text >>>>>>>>>> ${widget.text} and type ${widget.type}');
  }

  double width = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
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
                      padding: EdgeInsets.all(15),
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.grey.shade800),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.type,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Font',
                                fontSize: 16),
                          ),
                          widget.type == 'Text' ||
                                  widget.type == 'Website' ||
                                  widget.type == 'Location' ||
                                  widget.type == 'WhatsApp' ||
                                  widget.type == 'Email' ||
                                  widget.type == 'Twitter' ||
                                  widget.type == 'Instagram' ||
                                  widget.type == 'Telephone'
                              ? singlTextData(
                                  widget.type, widget.text.toString())
                              : widget.type == 'Wi-Fi'
                                  ? wifiData()
                                  : widget.type == 'Event'
                                      ? eventData()
                                      : widget.type == 'Contact'
                                          ? contactData()
                                          : widget.type == 'Business'
                                              ? businessData()
                                              : Container()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.08,
                    ),
                    Screenshot(
                      controller: screenshotController,
                      child: AnimatedContainer(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        duration: const Duration(seconds: 1),
                        width: _expanded ? width * 0.55 : 0,
                        height: _expanded ? height * 0.25 : 0,
                        child: _expanded
                            ? Code(
                                color: Colors.black,
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.yellow.shade700,
                                ),
                                data: qrString,
                                codeType: CodeType.qrCode(),
                              )
                            : null,
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
                                  _captureAndShareQRCode();
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
                            const Text(
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
                                  saveImage();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(seconds: 1),
                                      content:
                                          Text('Image Saved Successfully.'),
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
                            const Text(
                              'Save',
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
      ),
    );
  }

  singlTextData(String type, String data) {
    return Text(
      type == 'WhatsApp'
          ? "What's App Number : ${appTexts.text}"
          : type == 'Text'
              ? "${appTexts.text}"
              : type == 'Website'
                  ? "${appTexts.text}"
                  : type == "Location"
                      ? "${appTexts.text}"
                      : type == "Email"
                          ? "${appTexts.text}"
                          : type == "Twitter"
                              ? "Username : ${appTexts.text}"
                              : type == "Instagram"
                                  ? "Username : ${appTexts.text}"
                                  : type == 'Telephone'
                                      ? "Number : ${appTexts.text}"
                                      : "",
      style: const TextStyle(
          color: Colors.white, fontFamily: 'Font', fontSize: 16),
    );
  }

  wifiData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appWifi.wifiName!.isNotEmpty
            ? Text(
                "Network : ${appWifi.wifiName}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appWifi.security!.isNotEmpty
            ? Text(
                "Security : ${appWifi.security}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appWifi.hidden!.isNotEmpty
            ? Text(
                "Hidden : ${appWifi.hidden}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
      ],
    );
  }

  contactData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appContact.firstName!.isNotEmpty
            ? Text(
                "First Name : ${appContact.firstName}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appContact.lastName!.isNotEmpty
            ? Text(
                "Last Name : ${appContact.lastName}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appContact.company!.isNotEmpty
            ? Text(
                "Company : ${appContact.company}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appContact.job!.isNotEmpty
            ? Text(
                "Job : ${appContact.job}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appContact.phone!.isNotEmpty
            ? Text(
                "Phone : ${appContact.phone}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appContact.email!.isNotEmpty
            ? Text(
                "Email : ${appContact.email}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appContact.address!.isNotEmpty
            ? Text(
                "Address : ${appContact.address}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appContact.city!.isNotEmpty
            ? Text(
                "City : ${appContact.city}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appContact.country!.isNotEmpty
            ? Text(
                "Country : ${appContact.country}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
      ],
    );
  }

  eventData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appEvent.eventName!.isNotEmpty
            ? Text(
                "Event Name : ${appEvent.eventName}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appEvent.startTime != null
            ? Text(
                "Start Time : ${DateFormat('dd MMM yyyy').format(DateTime.parse(appEvent.startTime!))}, ${DateFormat.jm().format(DateTime.parse(appEvent.startTime!))}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appEvent.endtime!.isNotEmpty
            ? Text(
                "End Time : ${DateFormat('dd MMM yyyy').format(DateTime.parse(appEvent.endtime!))}, ${DateFormat.jm().format(DateTime.parse(appEvent.endtime!))}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appEvent.eventLocation!.isNotEmpty
            ? Text(
                "Event Location : ${appEvent.eventLocation}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appEvent.description!.isNotEmpty
            ? Text(
                "Description : ${appEvent.description}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
      ],
    );
  }

  businessData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appBusiness.companyName!.isNotEmpty
            ? Text(
                "Company Name : ${appBusiness.companyName}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appBusiness.industry!.isNotEmpty
            ? Text(
                "Industry : ${appBusiness.industry}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appBusiness.phone!.isNotEmpty
            ? Text(
                "Phone : ${appBusiness.phone}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appBusiness.email!.isNotEmpty
            ? Text(
                "Email : ${appBusiness.email}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appBusiness.website!.isNotEmpty
            ? Text(
                "Website : ${appBusiness.website}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appBusiness.address!.isNotEmpty
            ? Text(
                "Address : ${appBusiness.address}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appBusiness.city!.isNotEmpty
            ? Text(
                "City : ${appBusiness.city}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
        appBusiness.country!.isNotEmpty
            ? Text(
                "Country : ${appBusiness.country}",
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Font', fontSize: 16),
              )
            : Container(),
      ],
    );
  }
}

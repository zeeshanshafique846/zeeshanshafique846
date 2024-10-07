import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner_app/Scanned_item.dart';
import 'package:qr_code_scanner_app/barcode_result_screen.dart';
import 'package:qr_code_scanner_app/modals/app-event.dart';
import 'package:qr_code_scanner_app/modals/app_business.dart';
import 'package:qr_code_scanner_app/modals/app_contact.dart';
import 'package:qr_code_scanner_app/modals/app_singletexts.dart';
import 'package:qr_code_scanner_app/modals/app_wifi.dart';
import 'package:qr_code_scanner_app/new_page.dart';
import 'package:qr_code_scanner_app/on_click-items/wifi.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vibration/vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_ml_kit/google_ml_kit.dart' as ml;

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;

  // List<String> splittedList1 = [];
  QRViewController? controller;
  CameraFacing currentCamera = CameraFacing.back;
  bool isTorchOn = false;
  // XFile? selected_image;
  bool hasvibrated = false;
  bool vibrationon = true;
  bool hasBeeped = false;
  bool beepOn = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _qrCodeResult;
  final ImagePicker _picker = ImagePicker();
  int? qrHash = 373749376;
  int? barcodeHash = 48056403;

  @override
  void dispose() {
    controller?.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadVibrationBeepSetting();
  }

  Future _loadVibrationBeepSetting() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      vibrationon = prefs.getBool('vibration_on') ?? true;
      beepOn = prefs.getBool('beep_on') ?? true;
    });
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     controller!.resumeCamera();
  //   }
  // }

  Future<void> playBeepSound() async {
    try {
      // Play the beep sound from assets
      await _audioPlayer.play(AssetSource('beep-02.mp3'));
    } catch (e) {
      print("Error playing beep sound: $e");
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final File imageFile = File(image.path);
    _scanQRCodeFromImage(imageFile);
  }

  Future<void> _scanQRCodeFromImage(File imageFile) async {
    final inputImage = ml.InputImage.fromFile(imageFile);
    final barcodeScanner = ml.GoogleMlKit.vision.barcodeScanner();

    try {
      final List<ml.Barcode> barcodes =
          await barcodeScanner.processImage(inputImage);

      if (barcodes.isNotEmpty) {
        final ml.Barcode firstBarcode = barcodes.first;
        String barcodeType;

        debugPrint(
            'checking the type of image >>>>>>>> ${firstBarcode.format.name.hashCode}');
        // Check the format of the barcode
        if (firstBarcode.format == ml.BarcodeFormat.qrCode) {
          barcodeType = 'QR Code';
        } else {
          barcodeType = 'Barcode';
        }

        // Print the type of barcode for debugging purposes
        print('Scanned Barcode Type: $barcodeType');

        // Handle vibration and beep
        if (vibrationon && !hasvibrated) {
          if (await Vibration.hasVibrator() ?? false) {
            Vibration.vibrate(duration: 500);
            setState(() {
              hasvibrated = true;
            });
          }
        }

        if (beepOn && !hasBeeped) {
          await playBeepSound();
          setState(() {
            hasBeeped = true;
          });
        }

        // Get the barcode result
        _qrCodeResult = firstBarcode.rawValue;

        // Proceed with your logic to handle different types of scanned data
        if (barcodeType == 'QR Code') {
          // Handle QR code-specific logic
          List<String> splittedList = _qrCodeResult!.split(",,");
          String type = splittedList[0].split(" : ").last;

          // print("barcode result>>>>>>>> $splittedList1");

          if (type == 'Wi-Fi' ||
              type == 'Location' ||
              type == 'Contact' ||
              type == 'Event' ||
              type == 'Business') {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ScannedItem(
                          data: splittedList,
                          type: type,
                        )));
          } else {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ScannedItem(
                        type: type,
                        result: splittedList[0].replaceAll('\n', ''))));
          }
        } else {
          List<String> splittedList = _qrCodeResult!.split(",,");
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BarcodeResultScreen(
                        result: splittedList.toString(),
                      )));

          // Handle barcode-specific logic
          print('Barcode detected with value: $_qrCodeResult');
          // You can navigate to another screen or handle the result in some other way
        }

        setState(() {
          result = null;
          hasBeeped = false;
          hasvibrated = false;
        });
      }
    } catch (e) {
      setState(() {
        _qrCodeResult = 'Error scanning QR code: $e';
      });
    } finally {
      barcodeScanner.close();
    }
  }

//   Future<void> _scanQRCodeFromImage(File imageFile) async {
//     final inputImage = ml.InputImage.fromFile(imageFile);
//     final barcodeScanner = ml.GoogleMlKit.vision.barcodeScanner();

//     try {
//       final List<ml.Barcode> barcodes =
//           await barcodeScanner.processImage(inputImage);

//       if (barcodes.isNotEmpty) {
//         final ml.Barcode firstBarcode = barcodes.first;
//         String barcodeType;

//         // Check the format of the barcode
//         if (firstBarcode.format == ml.BarcodeFormat.qrCode) {
//           barcodeType = 'QR Code';
//         } else {
//           barcodeType = 'Barcode';
//           print("Scan result >>>>>> $barcodeType");
//         }

//         // Handle vibration
//         if (vibrationon && !hasvibrated) {
//           if (await Vibration.hasVibrator() ?? false) {
//             Vibration.vibrate(duration: 500);
//             setState(() {
//               hasvibrated = true;
//             });
//           }
//         }

//         // Handle beep sound
//         if (beepOn && !hasBeeped) {
//           await playBeepSound();
//           setState(() {
//             hasBeeped = true;
//           });
//         }

//         _qrCodeResult = barcodes.first.rawValue;

//         List<String> splitted_list = _qrCodeResult!.split(",,");
//         String type = splitted_list[0].split(" : ").last;
//         // AppWifi wifiModel = AppWifi();
//         // AppContact contactModel = AppContact();
//         // AppEvent eventModel = AppEvent();
//         // AppBusiness businessModel = AppBusiness();
//         // AppSingletexts textsModel = AppSingletexts();

//         print("check >>>>>>>>>>>>> $_qrCodeResult");
//         print("check >>>>>>>>>>>>> $type");

//         if (type == 'Wi-Fi' ||
//             type == 'Location' ||
//             type == 'Contact' ||
//             type == 'Event' ||
//             type == 'Business') {
//           await Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => ScannedItem(
//                         data: splitted_list,
//                         type: type,
//                       )));
//           setState(() {
//             result = null;
//             hasBeeped = false;
//             hasvibrated = false;
//           });
//         } else {
//           await Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => ScannedItem(
//                       type: type,
//                       result: splitted_list[0].replaceAll('\n', ''))));

//           setState(() {
//             result = null;
//             hasBeeped = false;
//             hasvibrated = false;
//           });

//           // setState(() {
//           //   _qrCodeResult = 'No QR code found';
//           // });
//         }
//         print("Scanned result >>>>>  $result");
//       }
// //below
//     } catch (e) {
//       setState(() {
//         _qrCodeResult = 'Error scanning QR code: $e';
//       });
//     } finally {
//       barcodeScanner.close();
//     }
//   }
  //1

  void _switchCamera() {
    if (controller != null) {
      // Toggle the camera between front and back
      if (currentCamera == CameraFacing.back) {
        currentCamera = CameraFacing.front;
      } else {
        currentCamera = CameraFacing.back;
      }
      controller!.flipCamera(); // This method flips the camera
      setState(() {}); // Update the UI
    }
  }

  void _toggleTorch() async {
    if (controller != null) {
      await controller!.toggleFlash();
      bool? isTorchActive = await controller!.getFlashStatus();
      setState(() {
        isTorchOn = isTorchActive ?? false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.04),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.05,
                right: width * 0.05,
              ),
              child: Container(
                  height: height * 0.08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey.shade800,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          _pickImage();
                        },
                        icon: Image.asset('assets/gallery.png',
                            width: 25, height: 25),
                      ),
                      IconButton(
                        onPressed: () {
                          _toggleTorch();
                        },
                        icon: Image.asset('assets/flash.png',
                            width: 25, height: 25),
                      ),
                      IconButton(
                        onPressed: () {
                          _switchCamera();
                        },
                        icon: Image.asset('assets/camera.png',
                            width: 25, height: 25),
                      ),
                    ],
                  )),
            ),
            Expanded(
              child: QRView(
                cameraFacing: CameraFacing.back,
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Color.fromARGB(255, 245, 182, 21),
                  borderRadius: 0.1,
                  borderLength: 32,
                  borderWidth: 25,
                  // cutOutSize: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
            ),
            (result == null)
                ? Container(
                    height: height * 0.13,
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        border: Border(
                            top: BorderSide(
                                color: Colors.yellow.shade700, width: 2))),
                    child: const Center(
                      child: Text(
                        'Scan a code',
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 30,
                            fontFamily: 'Font'),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    print("check result type : ${controller.hasPermissions}");
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      if (result == null) {
        setState(() {
          result = scanData;
        });

        // Print the result type
        // print("check result type : ${result!.code.toString()}");

        // Differentiate between QR code and barcode
        if (result != null) {
          if (result!.format == BarcodeFormat.qrcode) {
            print("This is a QR code");

            // Navigate to ScannedItem screen for QR codes
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScannedItem(
                  result: result!.code
                      ,
                ),
              ),
            ).then((_) {
              setState(() {
                result = null;
                hasvibrated = false;
                hasBeeped = false;
              });
            });
          } else {
            setState(() {
              result = scanData;
            });

            // Navigate to NewPage screen for barcodes
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BarcodeResultScreen(
                  result: result!.code.toString(),
                  // result: result!.code.toString(),
                ),
              ),
            ).then((_) {
              setState(() {
                result = null;
                hasvibrated = false;
                hasBeeped = false;
              });
            });
          }
          print("This is a Barcode of format: ${result!.format}");
        }

        // Vibration and Beep logic
        if (vibrationon && !hasvibrated) {
          Vibration.hasVibrator().then((hasVibrator) {
            if (hasVibrator == true) {
              Vibration.vibrate(duration: 500); // Vibrate once for 500 ms
              setState(() {
                hasvibrated =
                    true; // Set the flag to true to avoid multiple vibrations
              });
            }
          });
        }

        if (beepOn && !hasBeeped) {
          playBeepSound(); // Play beep sound
          setState(() {
            hasBeeped = true; // Set the flag to true to avoid multiple beeps
          });
        }
      }
    });
  }
}




   //   if (_qrCodeResult!.contains(type)) {
      //     if (type == 'Wi-Fi') {
      //       wifiModel = AppWifi(
      //         type: type,
      //         wifiName: splitted_list[1].split(" : ").last,
      //         password: splitted_list[2].split(" : ").last,
      //         security: splitted_list[3].split(" : ").last,
      //         hidden: splitted_list[4].split(" : ").last,
      //       );
      //     } else if (type == 'Event') {
      //       eventModel = AppEvent(
      //         type: type,
      //         eventName: splitted_list[1].split(" : ").last,
      //         startTime: splitted_list[2].split(" : ").last,
      //         endtime: splitted_list[3].split(" : ").last,
      //         eventLocation: splitted_list[4].split(" : ").last,
      //         description: splitted_list[5].split(" : ").last,
      //       );
      //     } else if (type == 'Contact') {
      //       contactModel = AppContact(
      //         type: type,
      //         firstName: splitted_list[1].split(" : ").last,
      //         lastName: splitted_list[2].split(" : ").last,
      //         company: splitted_list[3].split(" : ").last,
      //         job: splitted_list[4].split(" : ").last,
      //         phone: splitted_list[5].split(" : ").last,
      //         email: splitted_list[6].split(" : ").last,
      //         address: splitted_list[7].split(" : ").last,
      //         city: splitted_list[8].split(" : ").last,
      //         country: splitted_list[9].split(" : ").last,
      //       );
      //     } else if (type == 'Business') {
      //       businessModel = AppBusiness(
      //         type: type,
      //         companyName: splitted_list[1].split(" : ").last,
      //         industry: splitted_list[2].split(" : ").last,
      //         phone: splitted_list[3].split(" : ").last,
      //         email: splitted_list[4].split(" : ").last,
      //         website: splitted_list[5].split(" : ").last,
      //         address: splitted_list[6].split(" : ").last,
      //         city: splitted_list[7].split(" : ").last,
      //         country: splitted_list[8].split(" : ").last,
      //       );
      //     }
      //     setState(() {});
      //   } else {
      //     textsModel = AppSingletexts(text: _qrCodeResult!);
      //   }

      //   // if (type.toLowerCase() == 'wi-fi') {
      //   //   debugPrint('check pass >>>>>>>>>>>> ${wifiModel.password}');
      //   //   Navigator.push(
      //   //     context,
      //   //     MaterialPageRoute(
      //   //       builder: (context) => ScannedItem(result: _qrCodeResult),
      //   //     ),
      //   //   ).then((_) {
      //   //     setState(() {
      //   //       _qrCodeResult = null;
      //   //       hasvibrated = false;
      //   //       hasBeeped = false;
      //   //     });
      //   //   });
      //   // } else {
      //   //   setState(() {
      //   //     _qrCodeResult = 'No QR code found';
      //   //   });
      //   // }

      //   // if (type == 'event') {
      //   //   Navigator.push(
      //   //     context,
      //   //     MaterialPageRoute(
      //   //       builder: (context) => ScannedItem(result: eventModel),
      //   //     ),
      //   //   ).then((_) {
      //   //     setState(() {
      //   //       _qrCodeResult = null;
      //   //       hasvibrated = false;
      //   //       hasBeeped = false;
      //   //     });
      //   //   });
      //   // } else {
      //   //   setState(() {
      //   //     _qrCodeResult = 'No QR code found';
      //   //   });
      //   // }

      //   // if (type == 'contact') {
      //   //   Navigator.push(
      //   //     context,
      //   //     MaterialPageRoute(
      //   //       builder: (context) => ScannedItem(result: contactModel),
      //   //     ),
      //   //   ).then((_) {
      //   //     setState(() {
      //   //       _qrCodeResult = null;
      //   //       hasvibrated = false;
      //   //       hasBeeped = false;
      //   //     });
      //   //   });
      //   // } else {
      //   //   setState(() {
      //   //     _qrCodeResult = 'No QR code found';
      //   //   });
      //   // }

      //   // if (type == 'business') {
      //   //   Navigator.push(
      //   //     context,
      //   //     MaterialPageRoute(
      //   //       builder: (context) => ScannedItem(result: businessModel),
      //   //     ),
      //   //   ).then((_) {
      //   //     setState(() {
      //   //       _qrCodeResult = null;
      //   //       hasvibrated = false;
      //   //       hasBeeped = false;
      //   //     });
      //   //   });
      //   //   return;
      //   // } else {
      //   //   setState(() {
      //   //     _qrCodeResult = 'No QR code found';
      //   //   });
      //   //   return;
      //   // }

      //   // Navigator.push(
      //   //   context,
      //   //   MaterialPageRoute(
      //   //     builder: (context) => ScannedItem(result: textsModel.text),
      //   //   ),
      //   // ).then((_) {
      //   //   setState(() {
      //   //     _qrCodeResult = null;
      //   //     hasvibrated = false;
      //   //     hasBeeped = false;
      //   //   });
      //   // });

      // } else {
      //   setState(() {
      //     _qrCodeResult = 'No QR code found';
      //   });
      // }

//-----------
 //Check type  "Code-Type/BEGIN" result.contain'
  //List<String> => result.split by "%20"
  //Extract data from each String
  //Contact/Event ...
//------------------------------------------------------------
// String result = "BEGIN : contact,,FirstName : Zeeshan,, Lastname : Shafique";

//   List<String> splittedList = result.split(",,");
//   String type = splittedList[0].split(" : ").last;
//   String fname = splittedList[1].split(" : ").last;
//   String lname = splittedList[2].split(" : ").last;

//   print("$type | $fname | $lname");
//   if(type.tolowerCase() == "contact"){
//   Contact scannedObj =   Contact();
//   }else if( type == contact ){
//     Contact scannedObj =   Contact();
//   }

//   Navigate to ScannedResultScreen(
//     contact:

//   )
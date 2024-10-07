import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:qr_code_scanner_app/constans/app_text_styles.dart';
import 'package:qr_code_scanner_app/controller/history_controller.dart';
import 'package:qr_code_scanner_app/modals/ScanModel.dart';
import 'package:qr_code_scanner_app/qr_screens/qr_result_screen.dart';
import 'package:qr_code_scanner_app/services/database_services.dart';
import 'package:qr_code_scanner_app/utils/loading_widget.dart';

class Wifi extends StatefulWidget {
  final String heading2;
  const Wifi({Key? key, this.heading2 = ''}) : super(key: key);
  //const Wifi({super.key});

  @override
  State<Wifi> createState() => _WifiState();
}

class _WifiState extends State<Wifi> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController network = TextEditingController();
  TextEditingController password = TextEditingController();
  String selectedvalue = 'WPA';
  bool ischecked = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: LoadingWidget(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(51, 51, 51, 0.84),
        body: Padding(
          padding: EdgeInsets.only(
              top: height * 0.06, left: width * 0.06, right: width * 0.06),
          child: Form(
            key: _formKey,
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
                      widget.heading2,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: 'Font'),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.13,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 17, vertical: 30),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.yellow.shade700, width: 2),
                              top: BorderSide(
                                  color: Colors.yellow.shade700, width: 2)),
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.grey.shade800),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/wifi.png',
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Network',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Font'),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: AppTextStyles.validator,
                            controller: network,
                            autocorrect: true,
                            enableSuggestions: true,
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              errorStyle: AppTextStyles.errorTextstyle,
                              errorBorder: AppTextStyles.errorBorderStyle,
                              focusedErrorBorder:
                                  AppTextStyles.errorBorderStyle,
                              prefixText: ' ',
                              hoverColor: Colors.yellow.shade700,
                              hintText: 'Enter network name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusColor: Colors.white,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            cursorColor: Colors.yellow.shade700,
                          ),
                          SizedBox(
                            height: height * 0.017,
                          ),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Password',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Font'),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: AppTextStyles.validator,
                            enableSuggestions: true,
                            controller: password,
                            obscureText: true,
                            obscuringCharacter: '*',
                            style: TextStyle(color: Colors.white),
                            autocorrect: true,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              errorStyle: AppTextStyles.errorTextstyle,
                              errorBorder: AppTextStyles.errorBorderStyle,
                              focusedErrorBorder:
                                  AppTextStyles.errorBorderStyle,
                              prefixText: ' ',
                              hoverColor: Colors.yellow.shade700,
                              hintText: 'Enter password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusColor: Colors.white,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            cursorColor: Colors.yellow.shade700,
                          ),
                          SizedBox(
                            height: height * 0.017,
                          ),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Type of Encryption',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Font'),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.03),
                                  //width: width * 0.3,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButton(
                                    dropdownColor: Colors.grey.shade800,
                                    underline: Container(),
                                    borderRadius: BorderRadius.circular(10),
                                    items: const [
                                      DropdownMenuItem(
                                          value: 'WEP', child: Text('WEP')),
                                      DropdownMenuItem(
                                          value: 'WPA', child: Text('WPA')),
                                      DropdownMenuItem(
                                          value: 'WPA2-WAP',
                                          child: Text('WPA2-WAP')),
                                      DropdownMenuItem(
                                          value: 'None', child: Text('None'))
                                    ],
                                    value: selectedvalue,
                                    icon: Icon(
                                      Icons.arrow_drop_down_outlined,
                                      color: Colors.white,
                                    ),
                                    style: TextStyle(color: Colors.white),
                                    onChanged: (String? newvalue) {
                                      setState(() {
                                        selectedvalue = newvalue!;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.009,
                                ),
                                Container(
                                  // padding: EdgeInsets.only(right: 7),
                                  decoration: BoxDecoration(
                                      color: Colors.white12,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: ischecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            ischecked = value!;
                                          });
                                        },
                                      ),
                                      const Text(
                                        'Hidden Network',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Font',
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                )
                              ]),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                insertData();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.yellow.shade700,
                              ),
                              child: const Text(
                                'Generate QR Code',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Font',
                                    fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final _historyController = Get.put(HistoryConntroler());

  insertData() async {
    try {
      setState(() {
        isLoading = true;
      });
      HistoryModel row = HistoryModel(
        type: 'Wi-Fi',
        qrType: 'create',
        wifiName: network.text.trim(),
        password: password.text.trim(),
        protocol: selectedvalue.trim(),
        ishidden: ischecked ? '1' : '0',
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      );

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QrScreen(
              history: row,
              type: widget.heading2,
              dataList: [
                network.text,
                password.text,
                selectedvalue,
                ischecked.toString(),
              ],
            ),
          ));
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error to upload data  >>>>   $e');
      setState(() {
        isLoading = false;
      });
    }
  }
}

// ignore_for_file: use_super_parameters, non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:qr_code_scanner_app/constans/app_text_styles.dart';
import 'package:qr_code_scanner_app/controller/history_controller.dart';
import 'package:qr_code_scanner_app/history.dart';
import 'package:qr_code_scanner_app/modals/ScanModel.dart';
//import 'package:qr_code_scanner_app/qr.dart';
import 'package:qr_code_scanner_app/qr_screens/qr_result_screen.dart';
import 'package:qr_code_scanner_app/services/database_services.dart';
import 'package:qr_code_scanner_app/utils/loading_widget.dart';

class AppTextWidget extends StatefulWidget {
  final String text_from_home2;

  const AppTextWidget({Key? key, this.text_from_home2 = ''}) : super(key: key);
  // const AppTextWidget({super.key});

  @override
  State<AppTextWidget> createState() => _textwidgetState();
}

class _textwidgetState extends State<AppTextWidget> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController controller = TextEditingController();
  final _historyController = Get.put(HistoryConntroler());
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
                      widget.text_from_home2,
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
                            'assets/text.png',
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Text',
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
                            controller: controller,
                            autocorrect: true,
                            keyboardType: TextInputType.name,
                            style: TextStyle(color: Colors.white),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: AppTextStyles.validator,
                            decoration: InputDecoration(
                              //  prefixText: ' ',
                              hoverColor: Colors.yellow.shade700,
                              hintText: 'Enter text',
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
                              errorStyle: AppTextStyles.errorTextstyle,
                              focusedErrorBorder:
                                  AppTextStyles.errorBorderStyle,
                              errorBorder: AppTextStyles.errorBorderStyle,
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

  insertData() async {
    try {
      setState(() {
        isLoading = true;
      });
      // var directory;
      HistoryModel row = HistoryModel(
        type: 'Text',
        qrType: 'create',
        // imageUrl:
        title: controller.text.trim(),
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      );

      _historyController.updateHistory();

      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QrScreen(
              // firstname: controller.text,
              type: 'Text',
              text: controller.text,
              history: row,
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

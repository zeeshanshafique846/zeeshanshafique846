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

class Email extends StatefulWidget {
  final String heading8;
  const Email({Key? key, this.heading8 = ''}) : super(key: key);

  //const Email({super.key});

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController email = TextEditingController();
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
                      widget.heading8,
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
                            'assets/Email.png',
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Email',
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
                            controller: email,
                            autocorrect: true,
                            keyboardType: TextInputType.name,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              errorStyle: AppTextStyles.errorTextstyle,
                              errorBorder: AppTextStyles.errorBorderStyle,
                              focusedErrorBorder:
                                  AppTextStyles.errorBorderStyle,
                              prefixText: ' ',
                              hoverColor: Colors.yellow.shade700,
                              hintText: 'Enter email address',
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
                              child: Text(
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
        type: 'Email',
        qrType: 'create',
        email: email.text.trim(),
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      );

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QrScreen(
              history: row,
              type: widget.heading8,
              text: email.text,
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

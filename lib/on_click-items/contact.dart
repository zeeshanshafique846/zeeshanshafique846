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

class Contact extends StatefulWidget {
  final String heading4;
  const Contact({Key? key, this.heading4 = ''}) : super(key: key);
  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController job = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  bool isLoading = false;

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
              top: height * 0.06,
              left: width * 0.06,
              right: width * 0.06,
              bottom: height * 0.03),
          child: Form(
            key: _formkey,
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
                      widget.heading4,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: 'Font'),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 17, vertical: 30),
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
                            'assets/Contact.png',
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'First Name',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'Font'),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: AppTextStyles.validator,
                                      enableSuggestions: true,
                                      controller: firstname,
                                      autocorrect: true,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        errorStyle:
                                            AppTextStyles.errorTextstyle,
                                        errorBorder:
                                            AppTextStyles.errorBorderStyle,
                                        focusedErrorBorder:
                                            AppTextStyles.errorBorderStyle,
                                        prefixText: ' ',
                                        hoverColor: Colors.yellow.shade700,
                                        hintText: 'Enter name',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        focusColor: Colors.white,
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 2),
                                        ),
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      cursorColor: Colors.yellow.shade700,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Last Name',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'Font'),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: AppTextStyles.validator,
                                      enableSuggestions: true,
                                      controller: lastname,
                                      autocorrect: true,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        errorStyle:
                                            AppTextStyles.errorTextstyle,
                                        errorBorder:
                                            AppTextStyles.errorBorderStyle,
                                        focusedErrorBorder:
                                            AppTextStyles.errorBorderStyle,
                                        prefixText: ' ',
                                        hoverColor: Colors.yellow.shade700,
                                        hintText: 'Enter name',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        focusColor: Colors.white,
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 2),
                                        ),
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      cursorColor: Colors.yellow.shade700,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Company',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'Font'),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    TextField(
                                      enableSuggestions: true,
                                      controller: company,
                                      autocorrect: true,
                                      keyboardType: TextInputType.name,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        prefixText: ' ',
                                        hoverColor: Colors.yellow.shade700,
                                        hintText: 'Enter company',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        focusColor: Colors.white,
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 2),
                                        ),
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      cursorColor: Colors.yellow.shade700,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Job',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'Font'),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    TextField(
                                      enableSuggestions: true,
                                      controller: job,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      autocorrect: true,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        prefixText: ' ',
                                        hoverColor: Colors.yellow.shade700,
                                        hintText: 'Enter job',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        focusColor: Colors.white,
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 2),
                                        ),
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      cursorColor: Colors.yellow.shade700,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Phone',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'Font'),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: AppTextStyles.validator,
                                      enableSuggestions: true,
                                      controller: phone,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      autocorrect: true,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        errorStyle:
                                            AppTextStyles.errorTextstyle,
                                        errorBorder:
                                            AppTextStyles.errorBorderStyle,
                                        focusedErrorBorder:
                                            AppTextStyles.errorBorderStyle,
                                        prefixText: ' ',
                                        hoverColor: Colors.yellow.shade700,
                                        hintText: 'Enter phone',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        focusColor: Colors.white,
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 2),
                                        ),
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      cursorColor: Colors.yellow.shade700,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Email',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'Font'),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Field is required';
                                        } else if (validate_email(value) !=
                                            null) {
                                          return 'Email not valid';
                                        }
                                      },
                                      enableSuggestions: true,
                                      controller: email,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      autocorrect: true,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        errorStyle:
                                            AppTextStyles.errorTextstyle,
                                        errorBorder:
                                            AppTextStyles.errorBorderStyle,
                                        focusedErrorBorder:
                                            AppTextStyles.errorBorderStyle,
                                        prefixText: ' ',
                                        hoverColor: Colors.yellow.shade700,
                                        hintText: 'Enter email',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        focusColor: Colors.white,
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 2),
                                        ),
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      cursorColor: Colors.yellow.shade700,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Address',
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
                            controller: address,
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
                              hintText: 'Enter address',
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
                            height: height * 0.03,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'City',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'Font'),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    TextField(
                                      enableSuggestions: true,
                                      controller: city,
                                      style: TextStyle(color: Colors.white),
                                      autocorrect: true,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        prefixText: ' ',
                                        hoverColor: Colors.yellow.shade700,
                                        hintText: 'Enter city',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        focusColor: Colors.white,
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2),
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                      cursorColor: Colors.yellow.shade700,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Country',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'Font'),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    TextField(
                                      enableSuggestions: true,
                                      controller: country,
                                      style: TextStyle(color: Colors.white),
                                      autocorrect: true,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        prefixText: ' ',
                                        hoverColor: Colors.yellow.shade700,
                                        hintText: 'Enter country',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        focusColor: Colors.white,
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2),
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                      cursorColor: Colors.yellow.shade700,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formkey.currentState!.validate()) {
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

  String? validate_email(value) {
    if (value!.isEmpty) {
      return "Please enter your email";
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  final _historyController = Get.put(HistoryConntroler());

  insertData() async {
    try {
      setState(() {
        isLoading = true;
      });
      HistoryModel row = HistoryModel(
        type: 'Contact',
        qrType: 'create',
        firstName: firstname.text.trim(),
        lastName: lastname.text.trim(),
        company: company.text.trim(),
        job: job.text.trim(),
        phone: phone.text.trim(),
        email: email.text.trim(),
        address: address.text.trim(),
        city: city.text.trim(),
        country: country.text.trim(),
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      );

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QrScreen(
              history: row,
              type: widget.heading4,
              dataList: [
                firstname.text,
                lastname.text,
                company.text,
                job.text,
                phone.text,
                email.text,
                address.text,
                city.text,
                country.text
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

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

class Business extends StatefulWidget {
  final String heading5;
  const Business({Key? key, this.heading5 = ''}) : super(key: key);
  //const Business({super.key});

  @override
  State<Business> createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController companyname = TextEditingController();
  TextEditingController industry = TextEditingController();
  TextEditingController website = TextEditingController();
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
                        widget.heading5,
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
                          child: Column(children: [
                            Image.asset(
                              'assets/Bussiness.png',
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(
                              height: height * 0.04,
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Company name',
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
                              controller: companyname,
                              autocorrect: true,
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                errorStyle: AppTextStyles.errorTextstyle,
                                errorBorder: AppTextStyles.errorBorderStyle,
                                focusedErrorBorder:
                                    AppTextStyles.errorBorderStyle,
                                prefixText: ' ',
                                hoverColor: Colors.yellow.shade700,
                                hintText: 'Enter company',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
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
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2),
                                ),
                                hintStyle: const TextStyle(color: Colors.grey),
                              ),
                              cursorColor: Colors.yellow.shade700,
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Industry',
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
                              controller: industry,
                              autocorrect: true,
                              keyboardType: TextInputType.name,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                errorStyle: AppTextStyles.errorTextstyle,
                                errorBorder: AppTextStyles.errorBorderStyle,
                                focusedErrorBorder:
                                    AppTextStyles.errorBorderStyle,
                                prefixText: ' ',
                                hoverColor: Colors.yellow.shade700,
                                hintText: 'e.g Food/Agency',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
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
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2),
                                ),
                                hintStyle: const TextStyle(color: Colors.grey),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        autocorrect: true,
                                        style: const TextStyle(
                                            color: Colors.white),
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
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        validator: AppTextStyles.validator,
                                        controller: email,
                                        enableSuggestions: true,
                                        autocorrect: true,
                                        style: const TextStyle(
                                            color: Colors.white),
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
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
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
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Website',
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
                              controller: website,
                              autocorrect: true,
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                errorStyle: AppTextStyles.errorTextstyle,
                                errorBorder: AppTextStyles.errorBorderStyle,
                                focusedErrorBorder:
                                    AppTextStyles.errorBorderStyle,
                                prefixText: ' ',
                                hoverColor: Colors.yellow.shade700,
                                hintText: 'Enter website',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
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
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2),
                                ),
                                hintStyle: const TextStyle(color: Colors.grey),
                              ),
                              cursorColor: Colors.yellow.shade700,
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
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
                              autocorrect: true,
                              style: const TextStyle(color: Colors.white),
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
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
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
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2),
                                ),
                                hintStyle: const TextStyle(color: Colors.grey),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'City',
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
                                        controller: city,
                                        autocorrect: true,
                                        style: const TextStyle(
                                            color: Colors.white),
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
                                          hintText: 'Enter city',
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
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Country',
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
                                        controller: country,
                                        autocorrect: true,
                                        style: const TextStyle(
                                            color: Colors.white),
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
                                          hintText: 'Enter country',
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
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
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
                                padding: const EdgeInsets.all(13),
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
                          ])),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  final _historyController = Get.put(HistoryConntroler());

  insertData() async {
    try {
      setState(() {
        isLoading = true;
      });
      HistoryModel row = HistoryModel(
        type: 'Business',
        qrType: 'create',
        company: companyname.text.trim(),
        industry: industry.text.trim(),
        phone: phone.text.trim(),
        email: email.text.trim(),
        website: website.text.trim(),
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
              type: widget.heading5,
              dataList: [
                companyname.text,
                industry.text,
                phone.text,
                email.text,
                website.text,
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
//import 'package:textfields/textfields.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner_app/Scanned_item.dart';
import 'package:qr_code_scanner_app/constans/app_text_styles.dart';
import 'package:qr_code_scanner_app/controller/history_controller.dart';
import 'package:qr_code_scanner_app/modals/ScanModel.dart';
import 'package:qr_code_scanner_app/qr_screens/qr_result_screen.dart';
import 'package:qr_code_scanner_app/start_screen.dart';
import 'package:qr_code_scanner_app/services/database_services.dart';
import 'package:qr_code_scanner_app/utils/loading_widget.dart';

class Event extends StatefulWidget {
  final String heading3;
  const Event({Key? key, this.heading3 = ''}) : super(key: key);
  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  TextEditingController eventname = TextEditingController();
  DateTime now = DateTime.now();
  DateTime? startdate;
  TimeOfDay? starttime;
  DateTime? enddate;
  TimeOfDay? endtime;

  final _formKey = GlobalKey<FormState>();
  TextEditingController eventlocation = TextEditingController();
  TextEditingController description = TextEditingController();
  bool checkStartValidated = false;
  bool checkEndValidated = false;
  double width = 0;
  bool isLoading = false;
  double height = 0;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

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
                      widget.heading3,
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
                            'assets/Event.png',
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Event Name',
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
                            controller: eventname,
                            enableSuggestions: true,
                            autocorrect: true,
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              errorStyle: AppTextStyles.errorTextstyle,
                              errorBorder: AppTextStyles.errorBorderStyle,
                              focusedErrorBorder:
                                  AppTextStyles.errorBorderStyle,
                              prefixText: ' ',
                              hoverColor: Colors.yellow.shade700,
                              hintText: 'Enter name',
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
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Start Date and Time',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Font'),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          dateAndTimeCard(
                            onDateTap: () async {
                              DateTime? date = await datePickerFunction(0);
                              setState(() {
                                startdate = date!;
                              });
                            },
                            onTimeTap: () async {
                              if (startdate == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Please select start date first")));
                                return;
                              }
                              TimeOfDay? time = await timePickerFunction();
                              setState(() {
                                starttime = time!;
                              });
                            },
                            type: 'Start',
                            date: startdate,
                            time: starttime,
                          ),
                          SizedBox(
                            height: height * 0.017,
                          ),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'End Date and Time',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Font'),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          dateAndTimeCard(
                            onDateTap: () async {
                              DateTime? date = await datePickerFunction(1);
                              setState(() {
                                enddate = date!;
                              });
                            },
                            onTimeTap: () async {
                              if (enddate == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Please select end date first")));
                                return;
                              }
                              TimeOfDay? time = await timePickerFunction();
                              setState(() {
                                endtime = time!;
                              });
                            },
                            type: 'End',
                            date: enddate,
                            time: endtime,
                          ),
                          SizedBox(
                            height: height * 0.017,
                          ),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Event Location',
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
                            controller: eventlocation,
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
                              hintText: "Enter location",
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
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Description',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Font'),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          ExtendedTextField(
                            enableSuggestions: true,
                            controller: description,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixText: ' ',
                              hoverColor: Colors.yellow.shade700,
                              hintText: "Enter any details",
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
                            maxLines: 3,
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          GestureDetector(
                            onTap: () {
                              if ((startdate == null || starttime == null) &&
                                  (enddate == null || endtime == null) &&
                                  !_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                            'Start Date and Time is required')));
                                return;
                              }
                              if ((startdate == null || starttime == null) &&
                                  !_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                            'Start Date and Time is required')));
                                // setState(() {
                                //   checkStartValidated = true;
                                // });
                                return;
                              }
                              if ((enddate == null || endtime == null) &&
                                  !_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                            'End Date and Time is required')));

                                // setState(() {
                                //   checkEndValidated = true;
                                // });
                                return;
                              }
                              if ((startdate == null || starttime == null)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Start Date & Time is required')));
                                // setState(() {
                                //   checkStartValidated = true;
                                // });
                                return;
                              }
                              if ((enddate == null || endtime == null)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'End Date & Time is required')));

                                // setState(() {
                                //   checkEndValidated = true;
                                // });
                                return;
                              }
                              insertData();
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

  Future<DateTime?> datePickerFunction(int type) async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: type == 0 ? now : startdate!,
      lastDate: DateTime(
        now.year + 10,
        now.month,
        now.day,
      ),
    );
    return date;
  }

  Future<TimeOfDay?> timePickerFunction() async {
    TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    return time;
  }

  dateAndTimeCard({
    required void Function() onDateTap,
    required void Function() onTimeTap,
    required String type,
    DateTime? date,
    TimeOfDay? time,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height * 0.073,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onDateTap,
                  child: Container(
                    height: height * 0.073,
                    color: Colors.transparent,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      date == null
                          ? '$type Date'
                          : DateFormat('MMM dd, yyyy').format(date),
                      style: TextStyle(
                        color: date == null ? Colors.grey : Colors.white,
                        // fontSize: 14,
                        // fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: 0.5,
                  color: Colors.grey,
                ),
              ),
              Container(
                width: 15,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onTimeTap,
                  child: Container(
                    height: height * 0.073,
                    color: Colors.transparent,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      time == null
                          ? '$type Time'
                          : DateFormat.jm().format(DateTime(date!.year,
                              date.month, date.day, time.hour, time.minute)),
                      style: TextStyle(
                        color: time == null ? Colors.grey : Colors.white,
                        // fontSize: 14,
                        // fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        // checkStartValidated || checkEndValidated
        //     ? Text(
        //         '  Field is required',
        //         style: AppTextStyles.errorTextstyle.copyWith(fontSize: 12.5),
        //       )
        //     : Container()
      ],
    );
  }

  final _historyController = Get.put(HistoryConntroler());

  insertData() async {
    try {
      setState(() {
        isLoading = true;
      });
      DateTime selectedStartDate = DateTime(
        startdate!.year,
        startdate!.month,
        startdate!.day,
        starttime!.hour,
        starttime!.minute,
      );

      DateTime selectedEndDate = DateTime(
        enddate!.year,
        enddate!.month,
        enddate!.day,
        endtime!.hour,
        endtime!.minute,
      );

      HistoryModel row = HistoryModel(
        type: 'Event',
        qrType: 'create',
        title: eventname.text.trim(),
        startDateTime: selectedStartDate.toString().trim(),
        endDateTime: selectedEndDate.toString().trim(),
        eventLocation: eventlocation.text.trim(),
        eventDescription: eventlocation.text.trim(),
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      );

      // final rowInserted =
      //     await DatabaseHelper().insert(HistoryModel.toMap(row));
      // _historyController.updateHistory();
      // debugPrint("Inserted Row >>>> $rowInserted");

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QrScreen(
              history: row,
              type: widget.heading3,
              dataList: [
                eventname.text,
                selectedStartDate.toIso8601String(),
                selectedEndDate.toIso8601String(),
                eventlocation.text,
                description.text
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

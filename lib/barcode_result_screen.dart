import 'package:flutter/material.dart';
import 'package:qr_code_scanner_app/constans/country_map.dart';
import 'package:share_plus/share_plus.dart';

class BarcodeResultScreen extends StatefulWidget {
  final String? result;
  const BarcodeResultScreen({super.key, this.result});

  @override
  State<BarcodeResultScreen> createState() => _BarcodeResultScreenState();
}

class _BarcodeResultScreenState extends State<BarcodeResultScreen> {
  double width = 0;
  double height = 0;
  bool isClicked = false;
  // final isAlphabetic = RegExp(r'^[a-zA-Z]+$');

  // Function to determine the description based on the number
  String getDescriptionBasedOnNumber(String numberString) {
    String data = numberString.replaceAll('[', '').replaceAll(']', '');
    String numCheck = 'abcdefghijklmnopqrstuvwxyz';
    bool isNumber = true;

    for (var i = 0; i < data.length; i++) {
      if (numCheck.contains(data[i].toLowerCase())) {
        isNumber = false;
      }
    }

    print('is this a number >>>>>>>>> $isNumber and string >>> $data');

    if (isNumber) {
      int code;
      code = int.parse(data.substring(0, 3));

      print('code >>>>>>>>>>>>>>> $code');

      String result = 'Not Found';

      // Iterate through the country ranges
      for (var i = 0; i < CountryMap.ranges.length; i++) {
        String key = CountryMap.ranges.keys.elementAt(i);
        int firstValue = int.parse(key.split('-').first);
        int secondValue = int.parse(key.split('-').last);

        // Check if the parsed code is within the range
        if (code >= firstValue && code <= secondValue) {
          result = "This product belongs to ${CountryMap.ranges[key]}" ??
              'Not Found';
          break; // Exit the loop once a match is found
        }
      }

      print('Country found: $result');
      return " $result ";
    } else {
      return widget.result!.replaceAll('[', "").replaceAll("]", '');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        "string result >>>>>>>>>${getDescriptionBasedOnNumber(widget.result!)}");
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent,
          actions: [
            GestureDetector(
              onTap: () {
                Share.share("Hi");
              },
              child: Icon(
                Icons.share_outlined,
                size: 30,
              ),
            ),
            SizedBox(
              width: 15,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(40),
                      width: width,
                      color: Colors.lightGreenAccent,
                      child: Image.asset(
                        "assets/shoes1.png",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 14.0,
                        right: 14,
                        top: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.result
                                  .toString()
                                  .replaceAll("[", '')
                                  .replaceAll("]", ''),
                              style: TextStyle(
                                fontFamily: 'ibm',
                                fontSize: 28,
                                fontWeight: FontWeight.w400,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isClicked = !isClicked;
                              });
                            },
                            icon: Icon(
                              isClicked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isClicked ? Colors.red : Colors.black,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 14.0, right: 14, top: 10, bottom: 12),

                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(8),
                        color: Color(0xffE0E0E0),
                        child: Text(
                          getDescriptionBasedOnNumber(widget.result!)!,
                          style: TextStyle(fontFamily: 'ibm', fontSize: 16),
                        ),
                      ),
                      //  , child: Row(
                      //     children: [
                      //       Container(
                      //         padding: EdgeInsets.all(2),
                      //         color: Color(0xffE0E0E0),
                      //         child: Text(
                      //           "United States",
                      //           style: TextStyle(fontFamily: 'ibm', fontSize: 12),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: width * 0.06,
                      //       ),
                      //       Icon(
                      //         Icons.star,
                      //         size: 20,
                      //       ),
                      //       SizedBox(
                      //         width: width * 0.02,
                      //       ),
                      //       Text(
                      //         "4.3",
                      //         style: TextStyle(fontFamily: 'ibm', fontSize: 12),
                      //       ),
                      //       SizedBox(
                      //         width: width * 0.02,
                      //       ),
                      //       Text(
                      //         "(53 reviews )",
                      //         style: TextStyle(fontFamily: 'ibm', fontSize: 12),
                      //       ),
                      //     ],
                      //   ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Divider()),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 14.0, right: 14, bottom: 4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Description",
                          style: TextStyle(fontSize: 20, fontFamily: 'ibm'),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 14.0, right: 14, bottom: 13),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "No Product description available",
                          style: TextStyle(fontSize: 14, fontFamily: 'ibm'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 14.0,
                        right: 14,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Price",
                          style: TextStyle(fontSize: 12, fontFamily: 'ibm'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 14.0,
                        right: 14,
                        bottom: 40,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "\$690.00",
                          style: TextStyle(fontSize: 28, fontFamily: 'ibm'),
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Divider()),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

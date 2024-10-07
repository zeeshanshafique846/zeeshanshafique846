import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  double width = 0;
  double height = 0;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent,
          actions: [
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.share,
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
                          Text(
                            "Nike Air MAX 2022",
                            style: TextStyle(
                              fontFamily: 'ibm',
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Icon(Icons.favorite_outline, size: 30),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 14.0, right: 14, top: 10, bottom: 12),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            color: Color(0xffE0E0E0),
                            child: Text(
                              "United States",
                              style: TextStyle(fontFamily: 'ibm', fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.06,
                          ),
                          Icon(
                            Icons.star,
                            size: 20,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Text(
                            "4.3",
                            style: TextStyle(fontFamily: 'ibm', fontSize: 12),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Text(
                            "(53 reviews )",
                            style: TextStyle(fontFamily: 'ibm', fontSize: 12),
                          ),
                        ],
                      ),
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
                          "Lorem ipsum dolor sit amet consectetur. Malesuada faucibus viverra eget ridiculus a nec amet in. In turpis etiam tristique sit enim proin pulvinar.",
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

/** 
 * 
 * 
 * 
 * Column(children: [
        Container(
          height: height * 0.5,
          color: Colors.lightGreenAccent,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding:
                    EdgeInsets.only(right: width * 0.04, left: width * 0.004),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.share_outlined,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
        
            ],
          ),
        )
      ]), 
      
      
        Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nike Air MAX 2022",
                      style: TextStyle(fontFamily: 'Font'),
                    )
                  ],
                )
      */

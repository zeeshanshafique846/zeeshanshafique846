import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(51, 51, 51, 0.84),
      body: Padding(
        padding: EdgeInsets.only(
            top: height * 0.03,
            left: width * 0.06,
            right: width * 0.06,
            bottom: height * 0.03),
        child: ListView(
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
                  "Contact",
                  style: TextStyle(
                      color: Colors.white, fontSize: 22, fontFamily: 'Font'),
                )
              ],
            ),
            SizedBox(
              height: height * 0.06,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 30),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Colors.yellow.shade700, width: 2),
                      top: BorderSide(color: Colors.yellow.shade700, width: 2)),
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
                            Text(
                              'First Name',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Font'),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            TextField(
                              autocorrect: true,
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                prefixText: ' ',
                                hoverColor: Colors.yellow.shade700,
                                hintText: 'Enter name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
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
                              'Last Name',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Font'),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            TextField(
                              autocorrect: true,
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                prefixText: ' ',
                                hoverColor: Colors.yellow.shade700,
                                hintText: 'Enter name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
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
                            Text(
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
                              autocorrect: true,
                              keyboardType: TextInputType.name,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                prefixText: ' ',
                                hoverColor: Colors.yellow.shade700,
                                hintText: 'Enter company',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
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
                              style: TextStyle(color: Colors.white),
                              autocorrect: true,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                prefixText: ' ',
                                hoverColor: Colors.yellow.shade700,
                                hintText: 'Enter job',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
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
                            Text(
                              'Phone',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Font'),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            TextField(
                              style: TextStyle(color: Colors.white),
                              autocorrect: true,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                prefixText: ' ',
                                hoverColor: Colors.yellow.shade700,
                                hintText: 'Enter phone',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
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
                              'Email',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Font'),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            TextField(
                              style: TextStyle(color: Colors.white),
                              autocorrect: true,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                prefixText: ' ',
                                hoverColor: Colors.yellow.shade700,
                                hintText: 'Enter email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
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
                  TextField(
                    style: TextStyle(color: Colors.white),
                    autocorrect: true,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
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
                        borderSide: BorderSide(color: Colors.white, width: 2),
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
                              style: TextStyle(color: Colors.white),
                              autocorrect: true,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                prefixText: ' ',
                                hoverColor: Colors.yellow.shade700,
                                hintText: 'Enter city',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
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
                              style: TextStyle(color: Colors.white),
                              autocorrect: true,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                prefixText: ' ',
                                hoverColor: Colors.yellow.shade700,
                                hintText: 'Enter country',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
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
                    onTap: () {},
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
            )
          ],
        ),
      ),
    );
  }
}
  // Align(
  //                   alignment: Alignment.bottomLeft,
  //                   child: Text(
  //                     'Event Name',
  //                     style: TextStyle(
  //                         color: Colors.white,
  //                         fontSize: 15,
  //                         fontFamily: 'Font'),
  //                   ),
  //                 ),
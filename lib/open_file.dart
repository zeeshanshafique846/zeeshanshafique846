import 'package:flutter/material.dart';
//import 'package:qr_code_scanner_app/history.dart';
//import 'package:qr_code_scanner_app/start_screen.dart';
import 'package:intl/intl.dart';

class open_file extends StatefulWidget {
  const open_file({super.key});

  @override
  State<open_file> createState() => _open_fileState();
}

class _open_fileState extends State<open_file> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    DateTime now = DateTime.now();

    return Scaffold(
        backgroundColor: Color.fromRGBO(51, 51, 51, 0.84),
        body: Padding(
          padding: EdgeInsets.only(
              top: height * 0.06, left: width * 0.06, right: width * 0.06),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    "Result",
                    style: TextStyle(
                        color: Colors.white, fontSize: 22, fontFamily: 'Font'),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.grey.shade800),
                child: Column(
                  children: [
                    ListTile(
                      leading: Image.asset(
                        'assets/qr_start_screen.png',
                        height: 35,
                        width: 35,
                      ),
                      title: Text(
                        'Data',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        '${DateFormat('dd MMM yyyy').format(now)}, ${DateFormat.jm().format(now)}',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      width: width * 0.7,
                      child: Divider(
                        thickness: 0,
                        color: Colors.grey,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14.0, right: 14),
                        child: Text(
                          'sadkfdkfyafifuafajfkdndvkc',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.02, bottom: height * 0.02),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => show_qr(),
                              ));
                        },
                        child: Text(
                          'Show QR Code',
                          style: TextStyle(
                              color: Colors.yellow.shade700,
                              fontSize: 17,
                              fontFamily: 'Font'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.yellow.shade700),
                        child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/share.png',
                            color: Colors.black87,
                            height: 35,
                            width: 35,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      Text(
                        'Share',
                        style:
                            TextStyle(color: Colors.white, fontFamily: 'Font'),
                      )
                    ],
                  ),
                  SizedBox(
                    width: width * 0.1,
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.yellow.shade700),
                        child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/copy.png',
                            color: Colors.black87,
                            height: 35,
                            width: 35,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      Text(
                        'Copy',
                        style:
                            TextStyle(color: Colors.white, fontFamily: 'Font'),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  show_qr() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(51, 51, 51, 0.84),
      body: Padding(
        padding: EdgeInsets.only(
            top: height * 0.06, left: width * 0.06, right: width * 0.06),
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
                  "QR Code",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'Font',
                      decorationThickness: 0),
                )
              ],
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.grey.shade800),
              child: ListTile(
                title: Text(
                  'Data',
                  style: TextStyle(color: Colors.white, fontFamily: 'Font'),
                ),
                subtitle: Text(
                  'link',
                  style: TextStyle(color: Colors.white, fontFamily: 'Font'),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.08,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: Colors.yellow.shade700, width: 3)),
              child: Icon(
                Icons.qr_code,
                color: Colors.white,
                size: 160,
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.yellow.shade700),
                      child: IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/share.png',
                          color: Colors.black87,
                          height: 35,
                          width: 35,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    Text(
                      'Share',
                      style: TextStyle(color: Colors.white, fontFamily: 'Font'),
                    )
                  ],
                ),
                SizedBox(
                  width: width * 0.1,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.yellow.shade700),
                      child: IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/save.png',
                          color: Colors.black87,
                          height: 35,
                          width: 35,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontFamily: 'Font'),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

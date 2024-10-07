import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

// ignore: camel_case_types
class drawerr extends StatefulWidget {
  const drawerr({super.key});

  @override
  State<drawerr> createState() => _drawerrState();
}

class _drawerrState extends State<drawerr> {
  GlobalKey<ScaffoldState> scaffold_key = GlobalKey<ScaffoldState>();
  bool isOn = true;
  bool isOnn = true;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadVibrationSetting();
    _loadBeepSetting();
  }

  void _loadVibrationSetting() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isOn = prefs.getBool('vibration_on') ?? true;
    });
  }

  // Save vibration setting to shared preferences
  void _saveVibrationSetting(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('vibration_on', value);
  }

  //Beep
  Future<void> _loadBeepSetting() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isOnn = prefs.getBool('beep_on') ?? true;
    });
  }

  Future<void> _saveBeepSetting(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('beep_on', value);
  }

  Future<void> playBeepSound() async {
    try {
      await _audioPlayer.play(AssetSource('beep-02.mp3'));
    } catch (e) {
      print("Error playing beep sound: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: const Color.fromRGBO(51, 51, 51, 0.84),
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: height * 0.02, left: width * 0.06, right: width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.05,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Settings",
                      style: TextStyle(
                          fontFamily: 'Font',
                          fontSize: 26,
                          color: Colors.yellow.shade700),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.03,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.yellow.shade700, width: 2)),
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey.shade800),
                    child: ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 12, right: 2),
                        leading: Image.asset(
                          'assets/vibrate.png',
                          color: Colors.white,
                          height: 20,
                        ),
                        title: const Text(
                          "Vibrate",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        subtitle: const Text(
                          "Vibration when scan is done.",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        trailing: IconButton(
                          iconSize: 33,
                          onPressed: () {
                            setState(() {
                              isOn = !isOn;
                              _saveVibrationSetting(isOn);
                            });
                            if (isOn) {
                              // Trigger vibration when the button is turned on
                              Vibration.hasVibrator().then((hasVibrator) {
                                if (hasVibrator == true) {
                                  Vibration.vibrate();
                                }
                              });
                            }
                          },
                          icon: Icon(
                            isOn
                                ? Icons.toggle_on_outlined
                                : Icons.toggle_off_outlined,
                            color: isOn ? Colors.yellow.shade700 : Colors.grey,
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.03),
                  child: Container(
                    // height: 55,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.yellow.shade700, width: 2)),
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey.shade800),
                    child: ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 12, right: 2),
                        leading: Image.asset(
                          'assets/beep.png',
                          height: 20,
                          color: Colors.white,
                        ),
                        title: const Text(
                          "Beep",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        subtitle: const Text(
                          "Beep when scan is done.",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        trailing: IconButton(
                          iconSize: 33,
                          onPressed: () {
                            setState(() {
                              isOnn = !isOnn;
                              _saveBeepSetting(isOnn);
                            });

                            if (isOnn) {
                              playBeepSound();
                            }
                          },
                          icon: Icon(
                            isOnn
                                ? Icons.toggle_on_outlined
                                : Icons.toggle_off_outlined,
                            color: isOnn ? Colors.yellow.shade700 : Colors.grey,
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Text(
                  "Support",
                  style: TextStyle(
                      fontFamily: 'Font',
                      fontSize: 26,
                      color: Colors.yellow.shade700),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.grey.shade800),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/rate.png',
                                width: 25,
                                height: 25,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Rate Us",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    Text(
                                      "Your best reward to us.",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/share.png',
                              width: 25,
                              height: 25,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Share",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  Text(
                                    "Share app with others.",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/privacy_policy.png',
                              width: 25,
                              height: 25,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Privacy Policy",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  Text(
                                    "Follow our policies that benefits you.",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

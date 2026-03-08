import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../main.dart';
import '../routes/common_route_functions.dart';
import '../routes/route_paths.dart';
import '../utils/funtions/settings_utils.dart';
import '../utils/widgets/text_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double width = 0.0;
  double height = 0.0;
  DateTime? currentBackPressTime;
  SettingUtility settingUtility = SettingUtility();

  @override
  void initState() {
    startRouting();
    super.initState();
  }

  void startRouting() async {
    //ListClass.praiseList = await loadPraises('assets/data/praiseData.json');
    await settingUtility.initiateSettings();
    await initiateSettingValues();
    await Future.delayed(const Duration(seconds: 2));
    routePage(routeDashboard);
  }

  initiateSettingValues() async {
    await settingUtility.queryAllSettings();
    setState(() {
      MyApp.styles.fontFamily = settingUtility.returnSetting("FontFamily");
      MyApp.styles.fontStyle = settingUtility.returnSetting("FontStyle");
      MyApp.styles.fontWeight = settingUtility.returnSetting("FontWeight");
      MyApp.styles.fontSize =
          double.parse(settingUtility.returnSetting("FontSize") ?? "20.00");
      MyApp.styles.fontColor = Color(
          int.parse(settingUtility.returnSetting("FontColor") ?? "4294704123"));
      MyApp.styles.backType = settingUtility.returnSetting("BackType");
      MyApp.styles.backImage = settingUtility.returnSetting("BackImage");
      MyApp.styles.backColor = Color(
          int.parse(settingUtility.returnSetting("BackColor") ?? "429496729"));
    });
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      toast("Press back once again to exit.");
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      color: blackColor.withOpacity(0.7),
      child: WillPopScope(
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/splash.png',
                  height: 200,
                  width: 200,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: text("துதி பலிகள்",
                    isBold: true,
                    isItalic: true,
                    fontFamily: 'ArimaMadurai',
                    fontSize: 20.0,
                    textColor: Colors.black,
                    isCentered: true,
                    isLongText: true),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 5,
                width: width / 1.2,
                child: const LinearProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

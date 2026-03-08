// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:praise/screens/navigators/bottom_bar.dart';
import '../../main.dart';
import '../../models/device_settings.dart';
import '../../utils/funtions/common_utils.dart';
import '../../utils/funtions/settings_utils.dart';
import '../../utils/widgets/text_widget.dart';

class FontSettings extends StatefulWidget {
  const FontSettings({Key? key}) : super(key: key);

  @override
  _FontSettingsState createState() => _FontSettingsState();
}

class _FontSettingsState extends State<FontSettings> {
  String appfontFamily = 'Regular';
  String appfontStyle = 'Normal';
  String appfontWeight = 'Normal';
  double appfontSize = 15.0;
  Color appfontColor = Color(0xff443a49);

  double width = 0.0;
  double height = 0.0;
  SettingUtility settingUtility = SettingUtility();

  initiateSettingValues() async {
    await settingUtility.queryAllSettings();
    setState(() {
      appfontFamily = settingUtility.returnSetting("FontFamily");
      appfontStyle = settingUtility.returnSetting("FontStyle");
      appfontWeight = settingUtility.returnSetting("FontWeight");
      appfontSize = double.parse(settingUtility.returnSetting("FontSize"));
      appfontColor =
          Color(int.parse(settingUtility.returnSetting("FontColor")));
    });
  }

  @override
  void initState() {
    initiateSettingValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Font Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Font Family"), chooseFontFamily()],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Font Style"), chooseFontStyle()],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Font Weight"), chooseFontWeight()],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Font Size"), chooseFontSize()],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  InkWell(
                    onTap: () {
                      colorDialog();
                    },
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Font Color"),
                          Card(
                            elevation: 5,
                            child: Container(
                              width: 80,
                              height: 30,
                              color: appfontColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  sampleText(),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding:
            EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0, bottom: 20.0),
        child: SizedBox(
          width: width,
          height: 50,
          child: ElevatedButton(
            child: Text("Apply"),
            onPressed: () {
              applyStyles();
            },
          ),
        ),
      ),
    );
  }

  Widget chooseFontFamily() {
    return DropdownButton<String>(
      value: appfontFamily,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      underline: Container(
        height: 2,
      ),
      onChanged: (String? newValue) {
        setState(() {
          appfontFamily = newValue!;
        });
      },
      items: <String>[
        'Regular',
        'ArimaMadurai',
        'HindMadurai',
        'MeeraInimai',
        'NotoSansTamil',
        'Pavanam'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget chooseFontStyle() {
    return DropdownButton<String>(
      value: appfontStyle,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      underline: Container(
        height: 2,
      ),
      onChanged: (String? newValue) {
        setState(() {
          appfontStyle = newValue!;
        });
      },
      items: <String>['Normal', 'Italic']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget chooseFontWeight() {
    return DropdownButton<String>(
      value: appfontWeight,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      underline: Container(
        height: 2,
      ),
      onChanged: (String? newValue) {
        setState(() {
          appfontWeight = newValue!;
        });
      },
      items: <String>['Normal', 'Bold']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget chooseFontSize() {
    return Slider(
      value: appfontSize,
      max: 50,
      min: 10,
      divisions: 50,
      label: appfontSize.round().toString(),
      onChanged: (double value) {
        setState(() {
          appfontSize = value;
        });
      },
    );
  }

  colorDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick Color'),
          content: SizedBox(
            height: 350,
            width: 200,
            child: Column(
              children: [
                ColorPicker(
                  pickerAreaHeightPercent: 0.5,
                  pickerColor: appfontColor,
                  onColorChanged: changeColor,
                ),
              ],
            ),
          ),
          // actions: [
          //   ElevatedButton(
          //       onPressed: () {
          //         Navigator.pop(context);
          //       },
          //       child: Text("Cancel")),
          //   ElevatedButton(
          //       onPressed: () {
          //         Navigator.pop(context);
          //       },
          //       child: Text("Ok"))
          // ],
        );
      },
    );
  }

  void changeColor(Color color) {
    setState(() => appfontColor = color);
  }

  Widget sampleText() {
    return Card(
        elevation: 2.0,
        child: Container(
          height: 200,
          width: width,
          decoration: MyApp.styles.backType == "color"
              ? BoxDecoration(
                  color: MyApp.styles.backColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(color: Colors.white),
                  ],
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(color: Colors.white, spreadRadius: 3),
                  ],
                  image: DecorationImage(
                      image: decodeImage(MyApp.styles.backImage).image,
                      fit: BoxFit.cover)),
          child: Center(
            child: text("துதி பலிகள்",
                isBold: appfontWeight == "Bold" ? true : false,
                isItalic: appfontStyle == "Italic" ? true : false,
                fontFamily: appfontFamily,
                fontSize: appfontSize,
                textColor: appfontColor,
                isCentered: true,
                isLongText: true),
          ),
        ));
  }

  applyStyles() async {
    try {
      DeviceSettings settings = DeviceSettings();
      settings.key = "FontFamily";
      settings.value = appfontFamily;
      await settingUtility.updateSettings(settings);
      settings.key = "FontStyle";
      settings.value = appfontStyle;
      await settingUtility.updateSettings(settings);
      settings.key = "FontSize";
      settings.value = appfontSize.toString();
      await settingUtility.updateSettings(settings);
      settings.key = "FontWeight";
      settings.value = appfontWeight;
      await settingUtility.updateSettings(settings);
      settings.key = "FontColor";
      settings.value = appfontColor.value.toString();
      await settingUtility.updateSettings(settings);

      await settingUtility.queryAllSettings();
      setState(() {
        MyApp.styles.fontFamily = appfontFamily;
        MyApp.styles.fontStyle = appfontFamily;
        MyApp.styles.fontWeight = appfontFamily;
        MyApp.styles.fontSize = appfontSize;
        MyApp.styles.fontColor = Color(appfontColor.value);
      });
      toast("Successfullly updated");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomBar()));
    } catch (ex) {
      toast("Failed to update");
    }
  }
}

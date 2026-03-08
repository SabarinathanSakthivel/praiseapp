// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors, use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:praise/screens/navigators/bottom_bar.dart';

import '../../main.dart';
import '../../models/device_settings.dart';
import '../../utils/funtions/common_utils.dart';
import '../../utils/funtions/settings_utils.dart';
import 'background_image_gallery.dart';

class BackgroudSettings extends StatefulWidget {
  const BackgroudSettings({Key? key}) : super(key: key);

  @override
  _BackgroudSettingsState createState() => _BackgroudSettingsState();
}

class _BackgroudSettingsState extends State<BackgroudSettings> {
  String backType = "color";
  Color backgroundColor = Color(429496729);
  String backgroundImage =
      "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";
  Image? showImage;
  double width = 0.0;
  double height = 0.0;
  SettingUtility settingUtility = SettingUtility();
  initiateSettingValues() async {
    await settingUtility.queryAllSettings();
    setState(() {
      backType = settingUtility.returnSetting("BackType");
      backgroundImage = settingUtility.returnSetting("BackImage");
      backgroundColor =
          Color(int.parse(settingUtility.returnSetting("BackColor")));
      showImage = decodeImage(backgroundImage);
    });
  }

  @override
  void initState() {
    initiateSettingValues();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Background Settings"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(height: 30, child: Text("Backgrount Type")),
              radioButtons(),
              SizedBox(
                height: 5,
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              backType == "color"
                  ? InkWell(
                      onTap: () {
                        colorDialog();
                      },
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Choose Color"),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageGallery()),
                        ).then((value) {
                          setState(() {
                            backgroundImage = value;
                            showImage = decodeImage(backgroundImage);
                          });
                        });
                      },
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Choose Image"),
                            Icon(Icons.arrow_forward_ios)
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
                height: 20,
              ),
              sampleBackround(),
              SizedBox(
                height: 50,
              ),
            ],
          ),
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

  setbackType(val) {
    setState(() {
      backType = val;
    });
  }

  Widget radioButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(
          width: width / 2.5,
          child: RadioListTile(
            title: const Text("Colors"),
            value: "color",
            groupValue: backType,
            onChanged: (val) {
              setbackType(val);
            },
          ),
        ),
        SizedBox(
          width: width / 2.5,
          child: RadioListTile(
            title: const Text("Image"),
            value: "image",
            groupValue: backType,
            onChanged: (val) {
              setbackType(val);
            },
          ),
        ),
      ],
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
                  pickerColor: backgroundColor,
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
    setState(() => backgroundColor = color);
  }

  Widget sampleBackround() {
    return Align(
      alignment: Alignment.center,
      child: Card(
          elevation: 2.0,
          child: backType == "color"
              ? Container(
                  height: 400,
                  width: width / 2,
                  //color: backgroundColor,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.white),
                    ],
                  ),
                )
              : Container(
                  height: 400,
                  width: width / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(color: Colors.white, spreadRadius: 3),
                      ],
                      image: DecorationImage(
                          image: showImage!.image, fit: BoxFit.cover)))),
    );
  }

  applyStyles() async {
    try {
      DeviceSettings settings = DeviceSettings();
      settings.key = "BackType";
      settings.value = backType;
      await settingUtility.updateSettings(settings);
      settings.key = "BackImage";
      settings.value = backgroundImage;
      await settingUtility.updateSettings(settings);
      settings.key = "BackColor";
      settings.value = backgroundColor.value.toString();
      await settingUtility.updateSettings(settings);

      await settingUtility.queryAllSettings();
      setState(() {
        MyApp.styles.backType = backType;
        MyApp.styles.backImage = backgroundImage;
        MyApp.styles.backColor = Color(backgroundColor.value);
      });
      toast("Successfullly updated");
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomBar()));
    } catch (ex) {
      toast("Failed to update");
    }
  }
}

// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'backround_settings.dart';
import 'font_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
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
                ListTile(
                  leading: Icon(Icons.font_download),
                  title: Text("Font Settings"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FontSettings()),
                    );
                  },
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                ),
                ListTile(
                  leading: Icon(Icons.backpack),
                  title: Text("Backround Settings"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BackgroudSettings()));
                  },
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:praise/screens/navigators/aboutus_page.dart';
import 'package:praise/utils/funtions/common_functions.dart';
import 'package:share_plus/share_plus.dart';

import '../../screens/navigators/index_page.dart';
import '../../screens/settings/settings_page.dart';
import '../constants/constants.dart';
import 'text_widget.dart';

class BaseDrawer extends StatefulWidget {
  @override
  State<BaseDrawer> createState() => _BaseDrawerState();
}

class _BaseDrawerState extends State<BaseDrawer> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Drawer(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(children: <Widget>[
                  Container(
                    child: ListTile(
                        title: Text("THUDHI BALIGAL",
                            style: TextStyle(
                                fontSize: textSizeNormal,
                                fontFamily: fontMedium))),
                  ),
                  Divider(
                    height: 0,
                    thickness: 1,
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      ListTile(
                        leading: Icon(Icons.home),
                        title: text("Home"),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.info),
                        title: text("Index"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IndexPage()),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: text("Settings"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage()),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.share),
                        title: text("Share"),
                        onTap: () {
                          Navigator.pop(context);
                          Share.share(StringUrls.playstoreUrl,
                              subject: 'Praise App');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.rate_review),
                        title: text("Rate Us"),
                        onTap: () {
                          Navigator.pop(context);
                          CommonFunctions.openAppInPlayStore();
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: text("About"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutUsPage()),
                          );
                        },
                      )
                    ],
                  )),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

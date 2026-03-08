import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../utils/constants/colors.dart';
import '../settings/settings_page.dart';
import 'dashboard_page.dart';

int currentIndex = 0;
int selectedIndex = 0;

// currentIndex = 0 means Audio Main Page
// currentIndex = 1 means DashBoard Page
// currentIndex = 2 means Settings Page

class BottomBar extends StatefulWidget {
  final dynamic routeData;
  const BottomBar({
    this.routeData,
    Key? key,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  DateTime? currentBackPressTime;

  double width = 0.0;
  double height = 0.0;

  List<Widget> pagesList = [];

  List<Widget> returnBottomPages() {
    return [
      const DashBoardPage(),
      //const AudioMainPage(),
      const SettingsPage(),
    ];
  }

  changeIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  initPageDetails() async {
    currentIndex = selectedIndex;
    pagesList = returnBottomPages();
    selectedIndex = 0;
  }

  @override
  void initState() {
    initPageDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
        child: Center(
          child: pagesList.elementAt(currentIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            getBottomBarItemTile(
                const Icon(
                  Icons.dashboard,
                  size: 30,
                ),
                'DashBoard'),
            // getBottomBarItemTile(
            //     const Icon(
            //       Icons.audiotrack,
            //       size: 30,
            //     ),
            //     'Audio'),
            getBottomBarItemTile(
                const Icon(
                  Icons.settings,
                  size: 30,
                ),
                'Settings'),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          selectedItemColor: primaryBlue,
          backgroundColor: whiteColor,
          iconSize: 24,
          onTap: changeIndex,
          elevation: 3),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentIndex == 0) {
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        toast("Press back once again to exit.");
        return false;
      } else {
        return true;
      }
    } else {
      currentIndex = 0;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BottomBar()),
      );
      return false;
    }
  }

  getBottomBarItemTile(Widget icon, String title) {
    return BottomNavigationBarItem(
      icon: icon,
      activeIcon: icon,
      label: title,
    );
  }
}

import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".

  static Color fromHex(String hexString) {
    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (ex) {
      return Colors.white;
    }
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

final liteGrayColor = HexColor.fromHex('#FAFAFA');
final darkBlueColor = HexColor.fromHex("#0FA4DC");
final darkRedColor = HexColor.fromHex('#F75555');
final liteBlueBackGroundColor = HexColor.fromHex('#DBF2FA');
final liteRedColor = HexColor.fromHex('#FF1313');
final greenColor = HexColor.fromHex('#38C28F');
const textColorPrimary = Color(0XFF130925);
const textColorSecondary = Color(0XFF888888);
const textColorThird = Color(0XFFBABFB6);
const viewColor = Color(0XFFB4BBC2);
const teal = Colors.teal;
const whiteBackgroundColor = Color(0xFFFAFAFA);
const darkBlackColor = Color(0xFF000000);
const liteDimGreyColor = Color(0xFF808080);
const darkWhiteBackgroundColor = Color(0xFFF6F7FA);
const primaryBlue = Color(0xFF64B5F6);
const liteGray = Color(0xFFD6D6D6);
const Color primaryColor = Color(0xff003d00);
const Color primaryWhiteColor = Colors.white;
const Color primaryBlackColor = Colors.black;
const Color primaryGreyColor = Colors.grey;

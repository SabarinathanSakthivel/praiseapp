// ignore_for_file: avoid_print, deprecated_member_use

import 'package:nb_utils/nb_utils.dart';
import 'package:praise/utils/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonFunctions {
  static makeCall(String phoneNumber) {
    canLaunchUrl(Uri(scheme: 'tel', path: '+91 9360888460'))
        .then((bool result) async {
      if (result) {
        final Uri launchUri = Uri(
          scheme: 'tel',
          path: phoneNumber,
        );
        await launchUrl(launchUri);
      } else {
        toast("Couldn't make a call");
      }
    });
  }

  static makeEmail(String mailId) {
    canLaunchUrl(Uri(scheme: 'mailto', path: mailId)).then((bool result) async {
      if (result) {
        final Uri launchUri = Uri(
          scheme: 'mailto',
          path: mailId,
          query: encodeQueryParameters(
              <String, String>{'subject': 'Feedback about this app'}),
        );
        await launchUrl(launchUri);
      } else {
        toast("Couldn't make a email");
      }
    });
  }

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static openAppInPlayStore() async {
    Uri url = Uri.parse(StringUrls.playstoreUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      toast('Could not launch $url');
    }
  }

  static openGoogleMap(double latitude, double longitude) async {
    String googleMapUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    canLaunch(googleMapUrl).then((bool result) async {
      if (result) {
        await launch(googleMapUrl);
      } else {
        toast("Could not open the map.");
      }
    });
  }
}

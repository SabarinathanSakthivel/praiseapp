import 'package:flutter/material.dart';
import 'package:praise/screens/praises/praise_main_page.dart';
import '../screens/navigators/bottom_bar.dart';
import '../screens/splash_page.dart';
import '../utils/constants/colors.dart';
import 'route_paths.dart';

class RouteServices {
  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/':
        return null;
      case routeSplash:
        return MaterialPageRoute(builder: (_) {
          return const SplashPage();
        });
      case routeDashboard:
        selectedIndex = 0;
        return MaterialPageRoute(builder: (_) {
          return const BottomBar();
        });
      case routePraises:
        if (args is Map) {
          return MaterialPageRoute(builder: (_) {
            return ParaiseMainPage(
              praiseTypes: args["praiseTypes"],
            );
          });
        }
        return notFoundRoute();
      default:
        return null;
    }
  }

  static Route<dynamic> notFoundRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Page Not Found",
            style: TextStyle(color: primaryBlackColor),
          ),
        ),
      );
    });
  }
}

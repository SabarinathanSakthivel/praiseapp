import 'package:flutter/material.dart';
import 'models/common_styles.dart';
import 'routes/route_paths.dart';
import 'routes/route_services.dart';
import 'utils/constants/colors.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static CommonStyles styles = CommonStyles();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'துதி பலிகள்',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        primarySwatch: Colors.blue,
        fontFamily: 'NunitoSans',
        // appBarTheme: const AppBarTheme(
        //   color: Colors.transparent,
        //   elevation: 0,
        //   iconTheme: IconThemeData(color: primaryBlackColor),
        // ),
      ),
      initialRoute: routeSplash,
      onGenerateRoute: RouteServices.generateRoute,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: snackbarKey,
    );
  }
}

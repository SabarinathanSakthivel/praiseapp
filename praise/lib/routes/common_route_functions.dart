import '../main.dart';

routePage(String path, {Object? arguments}) {
  navigatorKey.currentState!.pushNamed(path, arguments: arguments);
}

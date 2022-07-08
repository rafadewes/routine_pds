import 'package:flutter/cupertino.dart';
import '../views/emocionario/emocionario.dart';
import '../views/habitos/habitos.dart';
import '../views/home/home.dart';
import '../views/login/login.dart';
import '../views/pomodoro/pomodoro.dart';
import '../views/splash/splash.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
    '/splash': (_) => const Splash(),
    '/home': (_) => const Home(),
    '/login': (_) => const Login(),
    '/emocionario': (_) => const EmocionarioScreen(),
    '/habitos': (_) => const HabitosScreen(),
    '/pomodoro': (_) => const Pomodoro(),
  };

  static String intial = '/splash';

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

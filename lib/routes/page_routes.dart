import 'package:apex_demo/constants/page_paths.dart';
import 'package:apex_demo/ui/screens/home_screen.dart';
import 'package:apex_demo/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';

class PageRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PagePaths.loginScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        );
      case PagePaths.homeScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        );
    }
  }
}

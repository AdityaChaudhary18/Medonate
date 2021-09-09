import 'package:flutter/material.dart';
import 'package:dose_care/Screens/pageNotFound.dart';
import 'package:dose_care/Screens/auth/login_page.dart';
import 'package:dose_care/Screens/auth/signup_view.dart';
import 'package:dose_care/Screens/dashboard/landing.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case '/landing':
        return MaterialPageRoute(builder: (_) => LandingPage());
      default:
        return MaterialPageRoute(builder: (_) => PageNotFound());
    }
  }
}

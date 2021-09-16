import 'package:flutter/material.dart';
import 'package:dose_care/Screens/pageNotFound.dart';
import 'package:dose_care/Screens/auth/login_page.dart';
import 'package:dose_care/Screens/auth/signup_main.dart';
import 'package:dose_care/Screens/dashboard/landing.dart';
import 'package:dose_care/Screens/auth/signup_individual.dart';
import 'package:dose_care/Screens/auth/signup_institution.dart';
import 'package:dose_care/Screens/intro/onboardingScreen.dart';

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
      case '/individual':
        return MaterialPageRoute(builder: (_) => SignUpIndividual());
      case '/institution':
        return MaterialPageRoute(builder: (_) => SignUpInstitution());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      default:
        return MaterialPageRoute(builder: (_) => PageNotFound());
    }
  }
}

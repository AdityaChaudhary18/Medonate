import 'package:flutter/material.dart';
import 'package:dose_care/Screens/pageNotFound.dart';
import 'package:dose_care/Screens/auth/login_page.dart';
import 'package:dose_care/Screens/auth/signup_main.dart';
import 'package:dose_care/Screens/dashboard/navBar.dart';
import 'package:dose_care/Screens/auth/signup_individual.dart';
import 'package:dose_care/Screens/auth/signup_institution.dart';
import 'package:dose_care/Screens/intro/onboardingScreen.dart';
import 'package:dose_care/Screens/dashboard/landing.dart';

import 'Screens/about/about.dart';
import 'Screens/main_pages/blood_donor.dart';
import 'Screens/main_pages/blood_home.dart';
import 'Screens/main_pages/equipment_donor.dart';
import 'Screens/main_pages/equipment_home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case '/navbar':
        return MaterialPageRoute(builder: (_) => NavBarPage());
      case '/landing':
        return MaterialPageRoute(builder: (_) => LandingPage());
      case '/individual':
        return MaterialPageRoute(builder: (_) => SignUpIndividual());
      case '/institution':
        return MaterialPageRoute(builder: (_) => SignUpInstitution());
      case '/about':
        return MaterialPageRoute(builder: (_) => AboutPage());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case '/main_pages':
        return MaterialPageRoute(builder: (_) => BloodHome());
      case '/bloodRequest':
        return MaterialPageRoute(builder: (_) => BloodDonor());
      case '/equiRequest':
        return MaterialPageRoute(builder: (_) => EquipmentDonor());
      case '/equiHome':
        return MaterialPageRoute(builder: (_) => EquipmentHome());

      default:
        return MaterialPageRoute(builder: (_) => PageNotFound());
    }
  }
}

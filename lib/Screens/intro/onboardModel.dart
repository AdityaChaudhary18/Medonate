import 'package:flutter/material.dart';

class OnBoardModel {
  final String img;
  final String text;
  final Color bg;
  final Color button;
  OnBoardModel(
      {required this.img,
      required this.text,
      required this.bg,
      required this.button});
}

List<OnBoardModel> screens = <OnBoardModel>[
  OnBoardModel(
    img: 'images/bloodIntro.svg',
    text: 'About 1 in 7 people entering a hospital need main_pages',
    bg: Colors.white,
    button: Color(0xFF004AAD),
  ),
  OnBoardModel(
    img: 'images/organIntro.svg',
    text: 'About 25-30 thousand liver transplants are needed annually in India',
    bg: Color(0xFF004AAD),
    button: Colors.white,
  ),
  OnBoardModel(
    img: 'images/medicalIntro.svg',
    text:
        'India has less than 50% of the ventilators than needed for Covid-19 treatment',
    bg: Colors.white,
    button: Color(0xFF004AAD),
  ),
];

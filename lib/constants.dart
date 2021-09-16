import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

var authTextFieldDecoration = InputDecoration(
  labelText: "Email",
  labelStyle: TextStyle(fontSize: 10.sp, color: Colors.black),
  errorStyle: TextStyle(fontSize: 10.sp),
  hintText: "Enter your email",
  hintStyle: TextStyle(fontSize: 10.sp, color: Color(0xFFAF9E9E)),
  contentPadding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 2.5.h),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(2.5.h),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(2.5.h),
    ),
    borderSide: BorderSide(
      width: 0.6.w,
    ),
  ),
);

Color kblue = Color(0xFF004AAD);
Color kwhite = Colors.white;
Color kblack = Colors.black;
Color kbrown = Color(0xFF795548);
Color kbrown300 = Color(0xFF8D6E63);
Color kgrey = Color(0xFFC0C0C0);

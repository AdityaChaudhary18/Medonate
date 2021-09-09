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

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:dose_care/utils/RoundedButton.dart';
import 'package:dose_care/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xFF004AAD),
        body: Column(
          children: [
            Container(
              height: 40.h,
              child: SvgPicture.asset(
                "images/logo.svg",
                fit: BoxFit.fitWidth,
                width: 100.w,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 8.h),
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.w),
                    topRight: Radius.circular(10.w),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8.5.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RoundedButton(
                        color: Color(0xFF004AAD),
                        onPressed: () {
                          Navigator.pushNamed(context, '/individual');
                        },
                        text: "INDIVIDUAL",
                      ),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RoundedButton(
                        color: Color(0xFF004AAD),
                        onPressed: () {
                          Navigator.pushNamed(context, '/institution');
                        },
                        text: "INSTITUTION",
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(fontSize: 11.sp),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.lightBlueAccent, fontSize: 11.sp),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

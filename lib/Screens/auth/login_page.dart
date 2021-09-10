import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:dose_care/constants.dart';
import 'package:dose_care/utils/RoundedButton.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextFormField(
                      decoration: authTextFieldDecoration,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    TextFormField(
                      controller: passwordController,
                      textAlign: TextAlign.center,
                      decoration: authTextFieldDecoration.copyWith(
                        labelText: "Password",
                        hintText: "Enter your Password",
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RoundedButton(
                        color: Color(0xFF004AAD),
                        onPressed: () {},
                        text: "LOG IN",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2.w),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    fontSize: 11.sp, color: Color(0xFFAF9E9E)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "New to MEDONATE? ",
                                style: TextStyle(fontSize: 11.sp),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.lightBlueAccent,
                                        fontSize: 11.sp),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

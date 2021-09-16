import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:dose_care/constants.dart';
import 'package:dose_care/utils/RoundedButton.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpIndividual extends StatefulWidget {
  const SignUpIndividual({Key? key}) : super(key: key);

  @override
  _SignUpIndividualState createState() => _SignUpIndividualState();
}

class _SignUpIndividualState extends State<SignUpIndividual> {
  bool agree = false;
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF004AAD),
      body: Column(
        children: [
          Container(
            height: 35.h,
            child: SvgPicture.asset(
              "images/logo.svg",
              fit: BoxFit.fitWidth,
              width: width,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 4.h),
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
                      "Individual Registration",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                      decoration: authTextFieldDecoration.copyWith(
                        labelText: "Name",
                        hintText: "Enter your Name",
                      ),
                      controller: nameController,
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    TextFormField(
                      decoration: authTextFieldDecoration,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    TextFormField(
                      controller: passwordController,
                      textAlign: TextAlign.center,
                      obscureText: _obscureText1,
                      decoration: authTextFieldDecoration.copyWith(
                        labelText: "Password",
                        hintText: "Enter your Password",
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText1
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscureText1 = !_obscureText1;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    TextFormField(
                      controller: confirmPasswordController,
                      textAlign: TextAlign.center,
                      obscureText: _obscureText2,
                      decoration: authTextFieldDecoration.copyWith(
                        labelText: "Confirm Password",
                        hintText: "Enter your Password again",
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText2
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscureText2 = !_obscureText2;
                            });
                          },
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Transform.scale(
                                scale: 0.23.w,
                                child: Checkbox(
                                  activeColor: Color(0xFF004AAD),
                                  value: agree,
                                  onChanged: (value) {
                                    setState(() {
                                      agree = !agree;
                                    });
                                  },
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  "I have read and accept terms and conditions",
                                  style: TextStyle(fontSize: 10.sp),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: RoundedButton(
                            color: agree ? Color(0xFF004AAD) : Colors.grey,
                            onPressed: () {
                              if (agree) {
                                Navigator.pushNamed(context, '/landing');
                              }
                            },
                            text: "LOG IN",
                          ),
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
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.lightBlueAccent,
                                    fontSize: 11.sp),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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

import 'package:firebase_auth/firebase_auth.dart';
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
  FirebaseAuth auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF004AAD),
      body: Column(
        children: [
          Container(
            height: 40.h,
            child: SvgPicture.asset(
              "images/logo.svg",
              fit: BoxFit.fitWidth,
              width: width,
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
                      obscureText: true,
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
                        onPressed: () async {
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                                    email: emailController.value.text,
                                    password: passwordController.value.text);
                            Navigator.pushReplacementNamed(context, '/navbar');
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found' ||
                                e.code == 'wrong-password') {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.lightBlue,
                                duration: Duration(seconds: 3),
                                content: Text(
                                  "Incorrect Email or Password!",
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        },
                        text: "LOG IN",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2.w),
                      child: Column(
                        children: [
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
                                    Navigator.pushReplacementNamed(
                                        context, '/signup');
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

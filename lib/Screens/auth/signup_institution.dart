import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:dose_care/constants.dart';
import 'package:dose_care/utils/RoundedButton.dart';

class SignUpInstitution extends StatefulWidget {
  const SignUpInstitution({Key? key}) : super(key: key);

  @override
  _SignUpInstitutionState createState() => _SignUpInstitutionState();
}

class _SignUpInstitutionState extends State<SignUpInstitution> {
  bool agree = false;
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  final instituteNameController = TextEditingController();
  final stateNameController = TextEditingController();
  final cityNameController = TextEditingController();
  final instituteIdController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w),
        child: Column(
          children: [
            Container(
              height: 12.h,
              child: SvgPicture.asset(
                "images/logoTrans.svg",
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Institution Registration",
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
                        labelText: "Institution Name",
                        hintText: "Enter your Institute's name",
                      ),
                      controller: instituteNameController,
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    TextFormField(
                      decoration: authTextFieldDecoration.copyWith(
                        labelText: "State",
                        hintText: "Enter your state",
                      ),
                      controller: stateNameController,
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    TextFormField(
                      decoration: authTextFieldDecoration.copyWith(
                        labelText: "City",
                        hintText: "Enter your city",
                      ),
                      controller: cityNameController,
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    TextFormField(
                      decoration: authTextFieldDecoration.copyWith(
                        labelText: "Institute ID",
                        hintText: "Enter your ID",
                      ),
                      controller: instituteIdController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    TextFormField(
                      decoration: authTextFieldDecoration.copyWith(
                        labelText: "Institute Email",
                        hintText: "Enter your Email",
                      ),
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
          ],
        ),
      ),
    );
  }
}
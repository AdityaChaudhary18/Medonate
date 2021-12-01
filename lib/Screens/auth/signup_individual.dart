import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:dose_care/constants.dart';
import 'package:dose_care/utils/RoundedButton.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpIndividual extends StatefulWidget {
  const SignUpIndividual({Key? key}) : super(key: key);

  @override
  _SignUpIndividualState createState() => _SignUpIndividualState();
}

class _SignUpIndividualState extends State<SignUpIndividual> {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference userIndi = FirebaseFirestore.instance.collection('users');
  bool agree = false;
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final locationController = TextEditingController();

  Future<void> signUpIndi() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.value.text,
              password: passwordController.value.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        final snackBar = SnackBar(
          backgroundColor: Colors.lightBlue,
          duration: Duration(seconds: 3),
          content: Text(
            "Weak-password",
            style: TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'email-already-in-use') {
        final snackBar = SnackBar(
          backgroundColor: Colors.lightBlue,
          duration: Duration(seconds: 3),
          content: Text(
            "Email-already-in-use!",
            style: TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print(e.toString());
    }
    return userIndi.doc(FirebaseAuth.instance.currentUser!.uid).set({
      'name': nameController.value.text,
      'email': emailController.value.text,
      'location': locationController.value.text,
      'type': "individual",
      'bloodD': 0,
      'bloodR': 0,
      'equipmentD': 0,
      'equipmentR': 0,
    }).then((value) {
      final snackBar = SnackBar(
        backgroundColor: Colors.lightBlue,
        duration: Duration(seconds: 3),
        content: Text(
          "Success!",
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushReplacementNamed(context, '/navbar');
    }).catchError((error) {
      final snackBar = SnackBar(
        backgroundColor: Colors.lightBlue,
        duration: Duration(seconds: 8),
        content: Text(
          error,
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  final formGlobalKey = GlobalKey<FormState>();

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
                child: Form(
                  key: formGlobalKey,
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter value';
                          }
                          return null;
                        },
                        controller: nameController,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      TextFormField(
                        decoration: authTextFieldDecoration.copyWith(
                          labelText: "City",
                          hintText: "Enter your City",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter value';
                          }
                          return null;
                        },
                        controller: locationController,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      TextFormField(
                        decoration: authTextFieldDecoration,
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter value';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      TextFormField(
                        controller: passwordController,
                        textAlign: TextAlign.center,
                        obscureText: _obscureText1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter value';
                          }
                          return null;
                        },
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter value';
                          }
                          return null;
                        },
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
                                if (formGlobalKey.currentState!.validate()) {
                                  formGlobalKey.currentState!.save();
                                  if (agree &&
                                      passwordController.value.text ==
                                          confirmPasswordController
                                              .value.text) {
                                    signUpIndi();
                                  }
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
                          SizedBox(
                            height: 3.5.h,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

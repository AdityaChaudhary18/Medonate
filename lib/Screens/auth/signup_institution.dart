import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> signUpInst() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailController.value.text, password: passwordController.value.text);
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
    return users.doc(FirebaseAuth.instance.currentUser!.uid).set({
      'name': instituteNameController.value.text,
      'email': emailController.value.text,
      'location': cityNameController.value.text,
      'type': "institution",
      'state': stateNameController.value.text,
      'instituteId': instituteIdController.value.text,
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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w),
        child: Form(
          key: formGlobalKey,
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
                      SizedBox(
                        height: 3.h,
                      ),
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter value';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      TextFormField(
                        decoration: authTextFieldDecoration.copyWith(
                          labelText: "State",
                          hintText: "Enter your state",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter value';
                          }
                          return null;
                        },
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter value';
                          }
                          return null;
                        },
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter value';
                          }
                          return null;
                        },
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter value';
                          }
                          return null;
                        },
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
                            icon: Icon(_obscureText1 ? Icons.visibility_off : Icons.visibility),
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
                            icon: Icon(_obscureText2 ? Icons.visibility_off : Icons.visibility),
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
                                  if (agree && passwordController.value.text == confirmPasswordController.value.text) {
                                    signUpInst();
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
                                  style: TextStyle(color: Colors.lightBlueAccent, fontSize: 11.sp),
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
      ),
    );
  }
}

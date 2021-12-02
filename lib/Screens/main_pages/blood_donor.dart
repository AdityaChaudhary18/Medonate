import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dose_care/utils/RoundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';

class BloodDonor extends StatelessWidget {
  const BloodDonor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final phoneNoController = TextEditingController();
    final locationController = TextEditingController();
    final groupController = TextEditingController();
    final emailController = TextEditingController();

    void addRequest() async {
      try {
        FirebaseFirestore.instance.collection('blood').add({
          "name": nameController.text,
          "age": int.parse(ageController.text),
          'contactNo': int.parse(phoneNoController.text),
          "location": locationController.text,
          'group': groupController.text,
          'email': emailController.text
        });
        var data = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        var number = data.get('bloodR');
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'bloodR': number + 1});
        Navigator.pop(context);
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Request Blood"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            children: [
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
                height: 3.h,
              ),
              TextFormField(
                decoration: authTextFieldDecoration.copyWith(
                  labelText: "Location",
                  hintText: "Enter your location",
                ),
                controller: locationController,
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              TextFormField(
                decoration: authTextFieldDecoration.copyWith(
                  labelText: "Age",
                  hintText: "Enter your age",
                ),
                controller: ageController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              TextFormField(
                decoration: authTextFieldDecoration.copyWith(
                  labelText: "Email",
                  hintText: "Enter your email",
                ),
                controller: emailController,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              TextFormField(
                controller: groupController,
                textAlign: TextAlign.center,
                decoration: authTextFieldDecoration.copyWith(
                  labelText: "Blood Group",
                  hintText: "Enter your blood group",
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              TextFormField(
                controller: phoneNoController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 10,
                decoration: authTextFieldDecoration.copyWith(
                  labelText: "Phone Number",
                  hintText: "Enter Phone Number",
                ),
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: RoundedButton(
                      color: Color(0xFF004AAD),
                      onPressed: () {
                        addRequest();
                      },
                      text: "Confirm",
                    ),
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
    );
  }
}

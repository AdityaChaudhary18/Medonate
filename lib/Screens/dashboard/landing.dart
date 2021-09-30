import 'package:flutter/material.dart';
import 'navBar.dart';
import 'package:sizer/sizer.dart';
import 'package:line_icons/line_icon.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        titleSpacing: 0,
        actions: [
          TextButton(
            onPressed: () {},
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.add_alert,
                color: Colors.black,
                size: 5.h,
              ),
            ),
          ),
        ],
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.account_circle_outlined,
            color: Colors.black,
            size: 5.h,
          ),
        ),
        title: Text(
          "MEDONATE",
          style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Container(
                  height: 20.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                ),
              ),
              Container(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}

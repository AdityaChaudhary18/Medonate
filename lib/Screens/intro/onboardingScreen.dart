import 'package:dose_care/Screens/auth/signup_main.dart';import 'package:flutter/cupertino.dart';import 'package:flutter/material.dart';import 'package:shared_preferences/shared_preferences.dart';import 'package:sizer/sizer.dart';import 'package:dose_care/Screens/intro/onboardModel.dart';import 'package:flutter_svg/flutter_svg.dart';import '../../constants.dart';class OnBoardingScreen extends StatefulWidget {  const OnBoardingScreen({Key? key}) : super(key: key);  @override  _OnBoardingScreenState createState() => _OnBoardingScreenState();}class _OnBoardingScreenState extends State<OnBoardingScreen> {  int _currentIndex = 0;  late PageController _pageController;  @override  void initState() {    _pageController = PageController(initialPage: 0);    super.initState();  }  @override  void dispose() {    _pageController.dispose();    super.dispose();  }  _storeOnBoardInfo() async {    int isViewed = 0;    SharedPreferences prefs = await SharedPreferences.getInstance();    await prefs.setInt('onBoard', isViewed);  }  @override  Widget build(BuildContext context) {    return Scaffold(      backgroundColor: _currentIndex % 2 == 0 ? kwhite : kblue,      appBar: AppBar(        backgroundColor: _currentIndex % 2 == 0 ? kwhite : kblue,        automaticallyImplyLeading: false,        elevation: 0,        actions: [          TextButton(            onPressed: () async {              await _storeOnBoardInfo();              Navigator.pushReplacement(                context,                MaterialPageRoute(                  builder: (context) => SignUpPage(),                ),              );            },            child: Text(              'Skip',              style: TextStyle(                  color: _currentIndex % 2 == 0 ? kblack : kwhite,                  fontSize: 13.sp,                  fontWeight: FontWeight.bold),            ),          ),        ],      ),      body: Padding(        padding: EdgeInsets.symmetric(horizontal: 5.w),        child: PageView.builder(          itemCount: screens.length,          controller: _pageController,          onPageChanged: (int index) {            setState(              () {                _currentIndex = index;              },            );          },          physics: NeverScrollableScrollPhysics(),          itemBuilder: (context, index) {            return Column(              mainAxisAlignment: MainAxisAlignment.spaceAround,              crossAxisAlignment: CrossAxisAlignment.center,              children: [                SvgPicture.asset(                  screens[index].img,                  height: 50.h,                  fit: BoxFit.fitWidth,                ),                Text(                  screens[index].text,                  textAlign: TextAlign.center,                  style: TextStyle(                    fontSize: 16.sp,                    fontWeight: FontWeight.bold,                    color: index % 2 == 0 ? kblack : kwhite,                  ),                ),                Row(                  mainAxisAlignment: MainAxisAlignment.spaceBetween,                  children: [                    Padding(                      padding: EdgeInsets.all(16.0),                      child: Container(                        height: 10.h,                        child: ListView.builder(                            itemCount: screens.length,                            shrinkWrap: true,                            scrollDirection: Axis.horizontal,                            itemBuilder: (_, index) {                              return Row(                                mainAxisAlignment: MainAxisAlignment.center,                                children: [                                  Container(                                    margin:                                        EdgeInsets.symmetric(horizontal: 1.w),                                    width: _currentIndex == index ? 7.w : 2.w,                                    height: 8.0,                                    decoration: BoxDecoration(                                      color: _currentIndex == index                                          ? kbrown                                          : kbrown300,                                      borderRadius: BorderRadius.circular(10.0),                                    ),                                  ),                                ],                              );                            }),                      ),                    ),                    MaterialButton(                      height: 10.h,                      onPressed: () async {                        await _storeOnBoardInfo();                        if (index == screens.length - 1) {                          Navigator.pushReplacement(                            context,                            MaterialPageRoute(                              builder: (context) => SignUpPage(),                            ),                          );                        }                        _pageController.nextPage(                            duration: Duration(milliseconds: 30),                            curve: Curves.bounceIn);                      },                      color: index % 2 == 0 ? Color(0xFF004AAD) : kwhite,                      textColor: Colors.white,                      child: Text(                        "Next",                        style: TextStyle(                            color: index % 2 == 0 ? kwhite : Color(0xFF004AAD),                            fontSize: 13.sp,                            fontWeight: FontWeight.bold),                      ),                      padding: EdgeInsets.all(16),                      shape: CircleBorder(),                    ),                  ],                )              ],            );          },        ),      ),    );  }}
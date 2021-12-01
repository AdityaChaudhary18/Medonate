import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dose_care/Screens/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dose_care/services/news.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

final List<String> imgList = [
  'images/home/fact1.png',
  'images/home/fact2.png',
  'images/home/fact3.png',
  'images/home/fact4.png',
  'images/home/fact5.png',
  'images/home/fact6.png',
  'images/home/fact7.png',
  'images/home/fact8.png',
];
final List<String> newsImgList = [];
final List<String> newsTitleList = [];
final List<String> articleUrlList = [];

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  CarouselController buttonCarouselController = CarouselController();
  NewsModel newsModel = NewsModel();
  var article;
  int activeIndex = 0;
  @override
  void initState() {
    super.initState();
    article = getNewsData();
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getNewsData() async {
    int i = 0;
    var data = await newsModel.getNews();

    for (var article in data) {
      if (i < 7) {
        newsImgList.add(article.urlToImage);
        newsTitleList.add(article.title);
        articleUrlList.add(article.articleUrl);
        i++;
      } else {
        return data;
      }
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/about');
          },
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.account_circle,
              color: Colors.black,
              size: 5.h,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            child: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onTap: () async {
              await logout();
            },
          )
        ],
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 265,
                child: FutureBuilder(
                  future: article,
                  builder: (context, data) {
                    if (data.hasData) {
                      return Padding(
                        padding: EdgeInsets.all(1.h),
                        child: Column(
                          children: [
                            CarouselSlider.builder(
                              options: CarouselOptions(
                                enlargeCenterPage: true,
                                viewportFraction: 0.75,
                                autoPlay: false,
                                onPageChanged: (index, reason) =>
                                    setState(() => activeIndex = index),
                              ),
                              itemCount: newsImgList.length,
                              itemBuilder: (context, index, realIndex) {
                                final image = newsImgList[index];
                                return buildNetworkImage(
                                    newsImgList[index],
                                    index,
                                    newsTitleList[index],
                                    articleUrlList[index]);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildIndicator(),
                          ],
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: CircularProgressIndicator(
                            color: Colors.black,
                          )),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text("Fetching News")
                        ],
                      );
                    }
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/equiHome');
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 2.h),
                  child: Container(
                    height: 15.h,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('equipment')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        var document = snapshot.data!.docs[0];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      document["name"],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      document["location"],
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      document["contactNo"].toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 20.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        document["type"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "*${document["quantity"].toString()}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/main_pages');
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Container(
                    height: 28.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: CarouselSlider.builder(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        viewportFraction: 1,
                        autoPlay: true,
                      ),
                      itemCount: imgList.length,
                      itemBuilder: (context, index, realIndex) {
                        final image = imgList[index];
                        return buildImage(imgList[index], index);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          child: Image.asset(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget buildNetworkImage(
          String urlImage, int index, String title, String urlLink) =>
      GestureDetector(
        onTap: () {
          _launchURL(urlLink);
        },
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            child: Stack(
              children: <Widget>[
                const Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                )),
                Container(
                  child: Center(
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      height: double.infinity,
                      image: urlImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Positioned(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          color: Colors.transparent.withOpacity(0.7),
                          child: Padding(
                            padding: EdgeInsets.all(2.h),
                            child: Center(
                              child: Text(
                                '$title',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  // fontFamily: 'Verdana'
                                ),
                              ),
                            ),
                          ),
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

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: newsImgList.length,
        effect: ScrollingDotsEffect(
          dotWidth: 10,
          dotHeight: 10,
          activeDotColor: Color(0xFF004AAD),
        ),
      );

  void _launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}

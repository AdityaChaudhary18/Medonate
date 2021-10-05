import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dose_care/services/news.dart';
import 'package:transparent_image/transparent_image.dart';

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

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  CarouselController buttonCarouselController = CarouselController();
  NewsModel newsModel = NewsModel();
  var article;

  @override
  void initState() {
    super.initState();
    article = getNewsData();
  }

  Future<dynamic> getNewsData() async {
    var data = await newsModel.getNews();
    for (var article in data) {
      newsImgList.add(article.urlToImage);
      newsTitleList.add(article.title);
    }
    return data;
  }

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Container(
                  height: 30.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: FutureBuilder(
                    future: article,
                    builder: (context, data) {
                      if (data.hasData) {
                        return CarouselSlider.builder(
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                            autoPlay: true,
                          ),
                          itemCount: newsImgList.length,
                          itemBuilder: (context, index, realIndex) {
                            final image = newsImgList[index];
                            return buildNetworkImage(newsImgList[index], index);
                          },
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
              Padding(
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
            ],
          ),
        ),
      ),
    );
  }
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

Widget buildNetworkImage(String urlImage, int index) => Container(
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        // child: Image.network(
        //   urlImage,
        //   fit: BoxFit.cover,
        // ),
        child: Stack(
          children: <Widget>[
            const Center(child: CircularProgressIndicator()),
            Center(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: urlImage,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );

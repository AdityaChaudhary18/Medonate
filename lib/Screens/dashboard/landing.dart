import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dose_care/services/news.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
  int activeIndex = 0;
  @override
  void initState() {
    super.initState();
    article = getNewsData();
  }

  Future<dynamic> getNewsData() async {
    int i = 0;
    var data = await newsModel.getNews();
    for (var article in data) {
      if (i < 7) {
        newsImgList.add(article.urlToImage);
        newsTitleList.add(article.title);
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
                  height: 32.h,
                  // decoration: BoxDecoration(
                  //   border: Border.all(
                  //     color: Colors.grey,
                  //     width: 2,
                  //   ),
                  //   borderRadius: BorderRadius.all(
                  //     Radius.circular(20.0),
                  //   ),
                  // ),
                  child: FutureBuilder(
                    future: article,
                    builder: (context, data) {
                      if (data.hasData) {
                        return Column(
                          children: [
                            CarouselSlider.builder(
                              options: CarouselOptions(
                                enlargeCenterPage: true,
                                viewportFraction: 1,
                                autoPlay: false,
                                onPageChanged: (index, reason) =>
                                    setState(() => activeIndex = index),
                              ),
                              itemCount: newsImgList.length,
                              itemBuilder: (context, index, realIndex) {
                                final image = newsImgList[index];
                                return buildNetworkImage(newsImgList[index],
                                    index, newsTitleList[index]);
                              },
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            buildIndicator(),
                          ],
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: CircularProgressIndicator()),
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

  Widget buildNetworkImage(String urlImage, int index, String title) =>
      Container(
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          child: Stack(
            children: <Widget>[
              const Center(child: CircularProgressIndicator()),
              Container(
                child: Center(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    height: double.infinity,
                    image: urlImage,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ),
              ),
              Positioned(
                top: 17.h,
                bottom: 0,
                left: 0,
                right: 0,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        color: Colors.transparent.withOpacity(0.7),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            '$title',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: newsImgList.length,
        effect: ExpandingDotsEffect(
          dotWidth: 10,
          dotHeight: 10,
        ),
      );
}

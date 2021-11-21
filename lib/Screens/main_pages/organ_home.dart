import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class OrganHome extends StatefulWidget {
  const OrganHome({Key? key}) : super(key: key);

  @override
  State<OrganHome> createState() => _OrganHomeState();
}

class _OrganHomeState extends State<OrganHome> {
  @override
  Widget build(BuildContext context) {
    Future<void> _launchInBrowser(String url) async {
      if (!await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      )) {
        throw 'Could not launch $url';
      }
    }

    Future<void> _makePhoneCall(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    CollectionReference bloodData =
        FirebaseFirestore.instance.collection('organs');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Organ Donation",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('images/home/organMain.jpg'),
              SizedBox(
                height: 7.h,
              ),
              Text(
                "Give the gift of life....",
                style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.pink,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Become an",
                style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Organ Donor",
                style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      _makePhoneCall('tel:1800114770');
                    }),
                    child: Row(
                      children: [
                        Icon(
                          Icons.call,
                          color: Colors.green,
                        ),
                        Text(
                          "1800-11-4770",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _launchInBrowser('https://www.notto.gov.in/');
                    }),
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.public,
                            color: Colors.green,
                          ),
                          Text(
                            "https://www.notto.gov.in/",
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

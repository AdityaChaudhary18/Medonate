import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  var uid;
  CollectionReference userData = FirebaseFirestore.instance.collection('users');

  void getCurrentUID() async {
    final user = FirebaseAuth.instance.currentUser;
    uid = user!.uid;
  }

  @override
  void initState() {
    getCurrentUID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Center(
          child: GestureDetector(
            child: Text(
              "Back",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: FutureBuilder(
        future: userData.doc(uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Center(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: 203,
                          width: 292,
                          child: Stack(
                            children: [
                              Image.asset('images/profileBack.png'),
                              Center(
                                child: Container(
                                  height: 95,
                                  width: 95,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            'images/shivansh.png',
                                          )),
                                      color: Colors.grey,
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          data['name'],
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "${data['type']}".toUpperCase(),
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      Text(
                        data['email'],
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      Text(
                        data['location'],
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 1.w),
                              child: Column(
                                children: [
                                  Text(
                                    "DONATION",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    height: 250,
                                    width: 45.w,
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 1.w),
                              child: Column(
                                children: [
                                  Text(
                                    "REQUESTS",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    height: 250,
                                    width: 45.w,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF5E17EB),
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

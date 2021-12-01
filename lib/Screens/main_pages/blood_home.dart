import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';

class BloodHome extends StatelessWidget {
  const BloodHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference bloodData =
        FirebaseFirestore.instance.collection('main_pages');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Blood Donation",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('blood').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                child: ListView(
                  children: <Widget>[
                    ...snapshot.data!.docs.map(
                      (document) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.40,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFF5E17EB),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                          )
                                        ],
                                      ),
                                      Text(
                                        document["group"],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )),
                            ),
                            secondaryActions: [
                              IconSlideAction(
                                caption: 'Donate',
                                color: Colors.green,
                                icon: Icons.check,
                                onTap: () async {
                                  final Email email = Email(
                                    body:
                                        'You have accepted the request for ${document["name"]} at ${document["location"]}.Contact at ${document["contactNo"]} for more details. Thanks for the help.',
                                    subject: 'MeDonate Donation Acceptance',
                                    recipients: [
                                      FirebaseAuth
                                              .instance.currentUser!.email ??
                                          'yayabud18@gmail.com'
                                    ],
                                    isHTML: false,
                                  );
                                  final Email email2 = Email(
                                    body:
                                        'You request has been accepted.Contact at ${FirebaseAuth.instance.currentUser!.email} for more details. Happy to help.',
                                    subject: 'MeDonate Donation Acceptance',
                                    recipients: [document["email"]],
                                    isHTML: false,
                                  );
                                  await FlutterEmailSender.send(email);
                                  await FlutterEmailSender.send(email2);
                                  await FirebaseFirestore.instance
                                      .collection('blood')
                                      .doc(document.id)
                                      .delete();
                                  await FirebaseFirestore.instance
                                      .collection('blood')
                                      .doc(document.id)
                                      .delete();
                                  var data = await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .get();
                                  var number = data.get('bloodD');
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .update({'bloodD': number + 1});
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 80.w),
                child: Align(
                  alignment: Alignment(1, 0.7),
                  child: Container(
                    width: 100.w,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/bloodRequest');
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

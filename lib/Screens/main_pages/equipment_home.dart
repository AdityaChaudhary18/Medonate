import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EquipmentHome extends StatelessWidget {
  const EquipmentHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference bloodData =
        FirebaseFirestore.instance.collection('equipment');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Equipment Donation",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('equipment').snapshots(),
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
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.indigoAccent,
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
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 30.w,
                                    child: Column(
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
                        Navigator.pushNamed(context, '/equiRequest');
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/services/notification_services.dart';

import '../../../components/notificationcard.dart';
import '../../../models/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  final String id;
  const NotificationScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    // NotificationServices().requestNotificationPermission();

    // NotificationServices().getDeviceToken().then((value) => {
    //       print("Device Token"),
    //       print(value),
    //     });
    // NotificationServices().setInteractMessage(context);
    // NotificationServices().firebaseInit(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 65,
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Padding(
              padding: const EdgeInsets.only(left: 12, top: 10),
              child: Text("Notifications",
                  style: GoogleFonts.montserrat(
                      textStyle:
                          const TextStyle(color: Colors.black, fontSize: 20)))),
        ),
        body: SafeArea(
          child: Text("ID" + widget.id),
        ));
  }
}

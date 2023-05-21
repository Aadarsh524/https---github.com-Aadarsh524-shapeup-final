import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/services/notification_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/notificationcard.dart';
import '../../../models/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

User? user = FirebaseAuth.instance.currentUser;
final userId = FirebaseAuth.instance.currentUser?.uid;
const successmessage = SnackBar(
  content: Text('Payment Failed'),
);

CollectionReference<Map<String, dynamic>> snapshot = FirebaseFirestore.instance
    .collection('notifications')
    .doc(user?.uid)
    .collection('list');

class _NotificationScreenState extends State<NotificationScreen> {
  String? premium;
  User? user = FirebaseAuth.instance.currentUser;

  setPremium() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      premium = prefs.getBool("premium").toString();
    });
  }

  @override
  void initState() {
    super.initState();
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
          child: StreamBuilder<List<NotificationModel>>(
            stream: NotificationServices(uID: user?.uid).getNotification,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return NotificationCard(
                          notification: snapshot.data![index].message);
                    });
              } else {
                return const CircularProgressIndicator();
              }
            }),
          ),
        ));
  }
}

import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

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
              child: Text("Notifications ",
                  style: GoogleFonts.montserrat(
                      textStyle:
                          const TextStyle(color: Colors.black, fontSize: 20)))),
        ),
        body: SafeArea(
          child: Text("ID${widget.id}",
              style: GoogleFonts.montserrat(
                  textStyle:
                      const TextStyle(color: Colors.black, fontSize: 20))),
        ));
  }
}

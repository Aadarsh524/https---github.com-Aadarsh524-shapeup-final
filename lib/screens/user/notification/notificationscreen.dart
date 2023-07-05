import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  final String title;
  final String body;

  const NotificationScreen({Key? key, required this.title, required this.body})
      : super(key: key);

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
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0, left: 15),
          child: SizedBox(
            width: double.infinity,
            child: LimitedBox(
              maxHeight: 200,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.body,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

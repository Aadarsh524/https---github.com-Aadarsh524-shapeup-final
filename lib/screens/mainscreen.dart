import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/login_screen.dart';

import '../services/firebaseservices.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // ignore: sized_box_for_whitespace
        body: SafeArea(
            child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: [
                    const Text("You are in Main screen"),
                    ElevatedButton.icon(
                      icon: const FaIcon(
                        FontAwesomeIcons.google,
                        size: 16,
                        color: Colors.orange,
                      ),
                      label: Text(
                        "Sign Out",
                        style: GoogleFonts.notoSansMono(
                            color: Colors.black.withOpacity(.75),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () async {
                        await FirebaseService().signOut();
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 250),
                                child: const LoginScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: const Color.fromARGB(255, 255, 234, 194),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ))));
  }
}

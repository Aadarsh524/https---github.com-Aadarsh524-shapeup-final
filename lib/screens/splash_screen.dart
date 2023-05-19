import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shapeup/screens/login_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/user/userDashboard/dashboardscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool pData = false;
  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;

    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          child: user != null ? const DashBoardScreen() : const LoginScreen(),
        ),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        // ignore: sized_box_for_whitespace
        body: SafeArea(
            child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.sports_gymnastics_outlined,
                        color: Colors.white,
                        size: 60.0,
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: Text(
                              "Shape Up",
                              style: Theme.of(context).textTheme.labelLarge,
                            )))
                  ],
                ))));
  }
}

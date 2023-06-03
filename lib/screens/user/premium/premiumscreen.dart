import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:shapeup/screens/user/premium/subscription_screen.dart';
import 'package:shapeup/screens/user/premium/trainerListScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chatScreen.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  late final Box dataBox;
  User? user = FirebaseAuth.instance.currentUser;
  final userId = FirebaseAuth.instance.currentUser?.uid;

  late bool premium;
  late bool hasTrainer;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('storage');
    premium = dataBox.get('premium');
    hasTrainer = dataBox.get('hasTrainer');
    print(hasTrainer);
    print(premium);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        body: premium == true
            ? (hasTrainer == true ? ChatScreen() : const TrainerListScreen())
            : const SubscriptionPage());
  }
}

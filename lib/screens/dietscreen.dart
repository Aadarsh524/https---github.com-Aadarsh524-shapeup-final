import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:blur/blur.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:styled_widget/styled_widget.dart';

import '../components/diet_card.dart';
import '../models/diet_model.dart';
import '../services/database_service.dart';

class DietScreen extends StatefulWidget {
  const DietScreen({Key? key}) : super(key: key);

  @override
  State<DietScreen> createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final userId = FirebaseAuth.instance.currentUser?.uid;

  bool? premium;
  Future asyncFunc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      premium = prefs.getBool("premium");
      print(premium);
    });
  }

  @override
  void initState() {
    super.initState();
    asyncFunc();
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
            child: Text("Your Diet",
                style: GoogleFonts.montserrat(
                    textStyle:
                        const TextStyle(color: Colors.black, fontSize: 20)))),
      ),
      body: StreamBuilder<List<DietModel>>(
        stream: DatabaseService().dietInfo,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return DietCard(dietModel: snapshot.data![index]);
                });
          } else {
            return const CircularProgressIndicator().center();
          }
        }),
      ),
    );
  }
}

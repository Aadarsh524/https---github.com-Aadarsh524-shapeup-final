import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:blur/blur.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../components/diet_card.dart';
import '../../../models/diet_model.dart';
import '../../../services/dietService.dart';

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
      backgroundColor: Color.fromARGB(255, 28, 28, 30),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        title: Text("Your Diet",
            style: GoogleFonts.montserrat(
                letterSpacing: .5,
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600)),
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        elevation: 0.0,
      ),
      body: FutureBuilder<List<DietModel>>(
        future: DietService().getDietInfo(),
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

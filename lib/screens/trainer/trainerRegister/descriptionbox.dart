import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
// import 'package:shapeup/screens/settingScreen.dart';
// import 'package:shapeup/screens/trainer/trainerRegister/filepicker.dart';
import 'package:shapeup/screens/trainer/trainerRegister/setting_screen.dart';

class DescBox extends StatefulWidget {
  const DescBox({Key? key}) : super(key: key);

  @override
  State<DescBox> createState() => _DescBoxState();
}

class _DescBoxState extends State<DescBox> {
  late String descrp;
  late Box dataBox;
  final _newDescController = TextEditingController();
  @override
  void initState() {
    dataBox = Hive.box('storage');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        body: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text('Let others know more about you.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      letterSpacing: .5,
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 12, left: 5, right: 5),
              padding: EdgeInsets.all(30),
              child: TextField(
                maxLength: 100,
                onChanged: (val) {},
                keyboardType: TextInputType.name,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
                controller: _newDescController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 39, 48, 81),
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Description(Less than 100 words)",
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 39, 48, 81),
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.description,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton.extended(
              onPressed: () async {
                if (_newDescController.text != '') {
                  await dataBox.put('descrp', _newDescController.text);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingUpScreenT()));
                } else {
                  SnackBar snackBar = SnackBar(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.white,
                    duration: const Duration(seconds: 2),
                    content: Text(
                      "Description can't be empty.",
                      style: GoogleFonts.montserrat(
                        height: .5,
                        letterSpacing: 0.5,
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              backgroundColor: const Color.fromARGB(
                255,
                208,
                253,
                62,
              ),
              label: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Next',
                      style: GoogleFonts.notoSansMono(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Icon(
                      size: 24,
                      Icons.arrow_right,
                      color: Colors.black,
                    )
                  ],
                ),
              )),
        ));
  }
}

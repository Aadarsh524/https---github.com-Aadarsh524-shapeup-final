import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/user/registration/settingScreen.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  bool isLoading = false;
  File? imagePath;

  late final Box dataBox;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('storage');
  }

  // void pickfile() async {
  //   try {
  //     result = await FilePicker.platform.pickFiles(
  //         type: FileType.any,
  //         allowMultiple: false); //allowedExtensions: ['pdf']);
  //     if (result != null) {
  //       _filename = result!.files.first.name;
  //       pickedfile = result!.files.first;
  //       imagePath = File(pickedfile!.path.toString());

  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   } catch (e) {}
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 28, 28, 30),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(children: [
              Center(
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Add your photo',
                    style: GoogleFonts.montserrat(
                        letterSpacing: .5,
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'This will be added to your profile',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        letterSpacing: .5,
                        color: const Color.fromARGB(255, 174, 155, 141),
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 360,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('')),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 214, 243, 155),
                    ),
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                    },
                    child: Text(
                      'Choose file',
                      style: GoogleFonts.notoSansMono(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ]),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton.extended(
              onPressed: () async {
                await dataBox.put('userImage', imagePath);
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 250),
                        child: const SettingUpScreen()));
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
                    const Icon(
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

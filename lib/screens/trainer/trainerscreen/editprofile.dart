import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  FilePickerResult? result;
  PlatformFile? pickedfile;
  File? fileToDisplay;

  final _newAgeController = TextEditingController();
  final _newDescController = TextEditingController();
  final _newExpController = TextEditingController();
  final _newPhoneController = TextEditingController();
  var phoneExpression = RegExp('[^0-9]');

  var authName = '';
  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      for (final providerProfile in user.providerData) {
        final name = providerProfile.displayName;
        setState(() {
          authName = name!;
        });
      }
    }
    super.initState();
  }

  void pickfile() async {
    try {
      result = await FilePicker.platform.pickFiles(
          type: FileType.any,
          allowMultiple: false); //allowedExtensions: ['pdf']);
      if (result != null) {
        pickedfile = result!.files.first;
        fileToDisplay = File(pickedfile!.path.toString());
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 28, 28, 30),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        elevation: 0,
        toolbarHeight: 60,
        title: Text("Update Profile",
            style: GoogleFonts.montserrat(
                letterSpacing: .5,
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600)),
        leading: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 114, 97, 89),
                  borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                color: Colors.black,
                iconSize: 18,
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                      bottom: 50,
                      top: 40,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Stack(children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: pickedfile != null
                                  ? Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: Image.file(
                                        fileToDisplay!,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : Image.asset(
                                      "assets/male.png",
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              margin: const EdgeInsets.only(left: 15),
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(100)),
                              child: IconButton(
                                color: Colors.white,
                                iconSize: 15,
                                icon: const Icon(Icons.camera_alt_outlined),
                                onPressed: () {
                                  pickfile();
                                },
                              ),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              bottom: 12, left: 5, right: 5),
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.deny(phoneExpression),
                            ],
                            onChanged: (val) {},
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.black.withOpacity(.75),
                            ),
                            controller: _newPhoneController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 39, 48, 81),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: "Phone",
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 39, 48, 81),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              prefixIcon: const Icon(
                                Icons.phone_android_outlined,
                                size: 20,
                                color: Color.fromRGBO(142, 153, 183, 0.5),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              bottom: 12, left: 5, right: 5),
                          child: TextFormField(
                            onChanged: (val) {},
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.black.withOpacity(.75),
                            ),
                            controller: _newExpController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 39, 48, 81),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: "Experience",
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 39, 48, 81),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              prefixIcon: const Icon(
                                Icons.description_outlined,
                                size: 20,
                                color: Color.fromRGBO(142, 153, 183, 0.5),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              bottom: 12, left: 5, right: 5),
                          child: TextFormField(
                            onChanged: (val) {},
                            keyboardType: TextInputType.name,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.black.withOpacity(.75),
                            ),
                            controller: _newDescController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 39, 48, 81),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: "Description",
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 39, 48, 81),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              prefixIcon: const Icon(
                                Icons.description_outlined,
                                size: 20,
                                color: Color.fromRGBO(142, 153, 183, 0.5),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              bottom: 12, left: 5, right: 5),
                          child: TextFormField(
                            onChanged: (val) {},
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.black.withOpacity(.75),
                            ),
                            controller: _newAgeController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 39, 48, 81),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: "Age",
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 39, 48, 81),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              prefixIcon: const Icon(
                                Icons.description_outlined,
                                size: 20,
                                color: Color.fromRGBO(142, 153, 183, 0.5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            print(_newAgeController.text);
            print(_newExpController.text);
            print(_newDescController.text);
            print(_newPhoneController.text);
            // await FirebaseFirestore.instance
            //     .collection('profile')
            //     .doc(user?.uid)
            //     .update({
            //   'age': _newAgeController.text,
            //   'descrip': _newDescController.text,
            //   'expage': _newExpController.text,
            //   'phone': _newPhoneController,
            // }).then((value) => Navigator.pushReplacement(
            //         context,
            //         PageTransition(
            //             type: PageTransitionType.fade,
            //             duration: const Duration(milliseconds: 250),
            //             child: const SettingUpScreenT())));
          },
          backgroundColor: const Color.fromARGB(
            255,
            208,
            253,
            62,
          ),
          label: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              'Update',
              style: GoogleFonts.notoSansMono(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          )),
    );
  }
}

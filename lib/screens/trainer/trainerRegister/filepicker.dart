import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/screens/trainer/trainerRegister/setting_screen.dart';

class Validation extends StatefulWidget {
  const Validation({Key? key}) : super(key: key);

  @override
  State<Validation> createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {
  FilePickerResult? result;
  String? _filename;
  PlatformFile? pickedfile;
  bool isLoading = false;
  File? fileToDisplay;
  User? user = FirebaseAuth.instance.currentUser;
  

  void pickfile() async {
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        setState(() {
          isLoading = true;
        });

        _filename = result!.files.first.name;
        pickedfile = result!.files.first;
        fileToDisplay = File(pickedfile!.path.toString());

        // Upload the file to Firebase Storage
        Reference ref =
            FirebaseStorage.instance.ref().child('users').child('user?.uid').child(_filename!);
        UploadTask uploadTask = ref.putFile(File(pickedfile!.path!));

        uploadTask.whenComplete(() async {
          // Get the download URL of the uploaded file
          String downloadURL = await ref.getDownloadURL();

          // Save the download URL to Firebase Firestore
          String uid = FirebaseAuth.instance.currentUser!.uid;
        DocumentReference documentRef = FirebaseFirestore.instance.collection('users').doc(uid);
        documentRef.set({
          'fileName': _filename,
          'downloadURL': downloadURL,
        }, SetOptions(merge: true));

          setState(() {
            isLoading = false;
          });
          print('File uploaded successfully');
        });
      }
    } catch (e) {
      print('Error picking/uploading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 28, 28, 30),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'ADD RESUME',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'We need to make sure that you are a proper trainer. Please provide any valid certification!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 174, 155, 141),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Note: The file should be in PDF format only!',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: const Color.fromARGB(
                            255,
                            208,
                            253,
                            62,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  width: 300,
                  child: isLoading
                      ? CircularProgressIndicator()
                      : pickedfile != null
                          ? Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Text(
                                _filename!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: const Color.fromARGB(
                                    255,
                                    208,
                                    253,
                                    62,
                                  ),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : Text(''),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 214, 243, 155),
                    ),
                    onPressed: () {
                      pickfile();
                    },
                    child: Text(
                      'Choose file',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
            padding: EdgeInsets.all(5),
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingUpScreenT()));
              },
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
              ),
            )));
  }
}

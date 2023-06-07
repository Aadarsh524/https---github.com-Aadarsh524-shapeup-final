// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';



// import '../trainerscreen/trainerscreen.dart';

// class Validation extends StatefulWidget {
//   const Validation({Key? key}) : super(key: key);

//   @override
//   State<Validation> createState() => _ValidationState();
// }

// class _ValidationState extends State<Validation> {
//   FilePickerResult? result;
//   String? _filename;
//   PlatformFile? pickedfile;
//   bool isLoading = false;
//   File? fileToDisplay;

//   void pickfile() async {
//     try {
//       result = await FilePicker.platform.pickFiles(
//           type: FileType.any,
//           allowMultiple: false); //allowedExtensions: ['pdf']);
//       if (result != null) {
//         _filename = result!.files.first.name;
//         pickedfile = result!.files.first;
//         fileToDisplay = File(pickedfile!.path.toString());

//         print(_filename);
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color.fromARGB(255, 28, 28, 30),
//         body: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(40),
//             child: Column(children: [
//               Center(
//                 child: Column(children: [
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     'ADD RESUME',
//                     style: GoogleFonts.montserrat(
//                         letterSpacing: .5,
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     'We need to make sure that you are a proper trainer.Please provide any valid cerfication!',
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.montserrat(
//                         letterSpacing: .5,
//                         color: Color.fromARGB(255, 174, 155, 141),
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   // Text(
//                   //   'Note: The file should be in pdf format only!',
//                   //   style: GoogleFonts.montserrat(
//                   //     fontSize: 15,
//                   //     fontWeight: FontWeight.normal,
//                   //     color: const Color.fromARGB(
//                   //       255,
//                   //       208,
//                   //       253,
//                   //       62,
//                   //     ),
//                   //   ),
//                   // ),
//                 ]),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                   height: 40,
//                   width: 300,
//                   child: isLoading
//                       ? CircularProgressIndicator()
//                       : pickedfile != null
//                           ? Container(
//                               padding: EdgeInsets.all(5),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(color: Colors.white)),
//                               child: Text(
//                                 _filename!,
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.notoSansMono(
//                                     fontSize: 16,
//                                     color: const Color.fromARGB(
//                                       255,
//                                       208,
//                                       253,
//                                       62,
//                                     ),
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             )
//                           : Text('')),
//               SizedBox(
//                 height: 20,
//               ),
//               Center(
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: const Color.fromARGB(255, 214, 243, 155),
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         isLoading = true;
//                       });
//                       pickfile();
//                     },
//                     child: Text(
//                       'Choose file',
//                       style: GoogleFonts.notoSansMono(
//                           fontSize: 16,
//                           color: Colors.black,
//                           fontWeight: FontWeight.w600),
//                     )),
//                 //Image.file(fileToDisplay!)
//               ),
//             ]),
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//         floatingActionButton: Padding(
//           padding: const EdgeInsets.only(bottom: 20),
//           child: FloatingActionButton.extended(
//               onPressed: () {
//                 // print(_ageController.text),
//                 //         await FirebaseFirestore.instance
//                 //             .collection('profile')
//                 //             .doc(user?.uid)
//                 //             .set({
//                 //           'age': _ageController.text,
//                 //         }).then((value) => Navigator.pushReplacement(
//                 //                 context,
//                 //                 PageTransition(
//                 //                     type: PageTransitionType.fade,
//                 //                     duration:
//                 //                         const Duration(milliseconds: 250),
//                 //                     child: const GenderScreen())));
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const TrainerPage()));
//               },
//               backgroundColor: const Color.fromARGB(
//                 255,
//                 208,
//                 253,
//                 62,
//               ),
//               label: SizedBox(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Next',
//                       style: GoogleFonts.notoSansMono(
//                           fontSize: 16,
//                           color: Colors.black,
//                           fontWeight: FontWeight.w600),
//                     ),
//                     Icon(
//                       size: 24,
//                       Icons.arrow_right,
//                       color: Colors.black,
//                     )
//                   ],
//                 ),
//               )),
//         ));
//   }
// }

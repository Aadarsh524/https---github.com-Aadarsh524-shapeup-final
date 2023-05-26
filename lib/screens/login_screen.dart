import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:shapeup/screens/trainer/trainerRegister/agescreen.dart';
import 'package:shapeup/screens/trainer/trainerscreen/trainerscreen.dart';

import 'package:shapeup/screens/user/userDashboard/dashboardscreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final Box dataBox;
  final auth = FirebaseAuth.instance;
  late String firstName;
  late String lastName;
  late String phone;
  late String userType;
  late String age;
  late String gender;
  late String height;
  late String weight;
  late String userImage;
  late String uid;
  late String email;
  late String calories;
  late String burn;
  late String glasses;
  late String carbs;
  late String protein;
  late String fat;
  late String fiber;
  late String bmi;
  late String expage;
  late String descrp;

  Future<void> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // await auth.setPersistence(Persistence.SESSION);
      UserCredential result = await auth.signInWithCredential(authCredential);

      if (result.additionalUserInfo!.isNewUser) {
        print("New User");
        SnackBar snackBar = SnackBar(
          padding: const EdgeInsets.all(20),
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 2),
          content: Text(
            "New user needs to register first",
            style: GoogleFonts.montserrat(
              height: .5,
              letterSpacing: 0.5,
              fontSize: 12,
              color: Colors.red,
            ),
          ),
        );
        result.user!.delete().then(
            (value) => ScaffoldMessenger.of(context).showSnackBar(snackBar));

        GoogleSignIn googleSignIn = GoogleSignIn();
        await googleSignIn.signOut();
      } else {
        print("Old User");

        final User? user = auth.currentUser;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) async {
          if (documentSnapshot.exists) {
            print("User Data");

            dataBox = Hive.box('storage');
            Map<String, dynamic> data =
                documentSnapshot.data() as Map<String, dynamic>;
            if (data['userType'] == 'trainee') {
              userType = data['userType'];
              firstName = data['firstName'];
              lastName = data['lastName'];
              phone = data['phone'];
              age = data['age'];
              gender = data['gender'];
              height = data['height'];
              weight = data['weight'];
              userImage = data['userImage'];
              email = data['email'];
              calories = data['calories'];
              burn = data['burn'];
              glasses = data['glasses'];
              carbs = data['carbs'];
              fat = data['fat'];
              protein = data['protein'];
              fiber = data['fiber'];
              bmi = data['bmi'];
              uid = data['uid'];

              await dataBox.put('firstName', firstName);
              await dataBox.put('lastName', lastName);
              await dataBox.put('phone', phone);
              await dataBox.put(
                'userType',
                userType,
              );
              await dataBox.put('uid', uid);
              await dataBox.put('email', email);
              await dataBox.put('age', age);
              await dataBox.put('gender', gender);
              await dataBox.put('height', height);
              await dataBox.put('weight', weight);
              await dataBox.put('userImage', userImage);

              await dataBox.put('calories', calories);
              await dataBox.put('burn', burn);
              await dataBox.put('glasses', glasses);
              await dataBox.put('bmi', bmi);
              await dataBox.put('carbs', carbs);
              await dataBox.put('protein', protein);
              await dataBox.put('fat', fat);
              await dataBox.put('fiber', fiber);

              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 250),
                      child: const DashBoardScreen()));
            } else {
              userType = data['userType'];
              firstName = data['firstName'];
              lastName = data['lastName'];
              phone = data['phone'];
              age = data['age'];
              gender = data['gender'];
              expage = data['expage'];
              userImage = data['userImage'];
              descrp = data['descrp'];
              uid = data['uid'];
              email = data['email'];

              await dataBox.put('firstName', firstName);
              await dataBox.put('lastName', lastName);
              await dataBox.put('phone', phone);
              await dataBox.put(
                'userType',
                userType,
              );
              await dataBox.put('uid', uid);
              await dataBox.put('age', age);
              await dataBox.put('expage', expage);
              await dataBox.put('descrp', descrp);
              await dataBox.put('gender', gender);
              await dataBox.put('userImage', userImage);
               await dataBox.put('email', email);

              print(firstName);
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 250),
                      child: const TrainerPage()));
            }
          } else {
            print("Registration process was not completed.");

            SnackBar snackBar = SnackBar(
              padding: const EdgeInsets.all(20),
              backgroundColor: Colors.white,
              duration: const Duration(seconds: 2),
              content: Text(
                "Registration process was sabotaged before.",
                style: GoogleFonts.montserrat(
                  height: .5,
                  letterSpacing: 0.5,
                  fontSize: 12,
                  color: Colors.red,
                ),
              ),
            );
            SnackBar snackBar2 = SnackBar(
              padding: const EdgeInsets.all(20),
              backgroundColor: Colors.white,
              duration: const Duration(seconds: 2),
              content: Text(
                "Please register again.",
                style: GoogleFonts.montserrat(
                  height: .5,
                  letterSpacing: 0.5,
                  fontSize: 12,
                  color: Colors.red,
                ),
              ),
            );
            result.user!
                .delete()
                .then((value) =>
                    ScaffoldMessenger.of(context).showSnackBar(snackBar))
                .then((value) =>
                    ScaffoldMessenger.of(context).showSnackBar(snackBar2));

            GoogleSignIn googleSignIn = GoogleSignIn();
            await googleSignIn.signOut();
          }
        });
      }
    }
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
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                          "assets/loginto.png",
                          colorBlendMode: BlendMode.colorBurn,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Welcome to",
                        style: GoogleFonts.montserrat(
                          height: .5,
                          letterSpacing: 0.5,
                          fontSize: 16,
                          color: Color.fromARGB(255, 125, 128, 122),
                        ),
                      ),
                      Text(
                        "Shape Up",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                          fontSize: 28,
                          color: Color.fromARGB(255, 190, 227, 57),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Make yourself stronger than your excuses.",
                        style: GoogleFonts.manjari(
                          height: .5,
                          letterSpacing: 0.5,
                          fontSize: 12,
                          color: Color.fromARGB(255, 125, 128, 122),
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const FaIcon(
                            FontAwesomeIcons.google,
                            size: 16,
                            color: Colors.black,
                          ),
                          label: Text(
                            "Login  With Google",
                            style: GoogleFonts.notoSansMono(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () async {
                            await loginWithGoogle();
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              textStyle: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have a account? ",
                            style: GoogleFonts.montserrat(
                              letterSpacing: .4,
                              fontSize: 11,
                              color:
                                  Color.fromARGB(255, 0, 0, 0).withOpacity(.65),
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              "Register",
                              style: GoogleFonts.montserrat(
                                letterSpacing: .4,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 25, 170, 151),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: const RegisterScreen()));
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }
}

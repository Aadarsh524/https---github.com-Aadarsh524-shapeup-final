import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shapeup/bloc/cubit/register_cubit.dart';
import 'package:shapeup/screens/trainer/trainerRegister/agescreen.dart';
import 'package:shapeup/screens/trainer/trainerRegister/genderscreen.dart';

import 'package:shapeup/screens/user/userRegister/agescreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

import '../components/account_types.dart';
import 'login_screen.dart';
import 'package:hive/hive.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

enum AccountType {
  trainee,
  trainer,
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final Box dataBox;
  final auth = FirebaseAuth.instance;

  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController accountTypeController = TextEditingController();
  var phoneExpression = RegExp('[^0-9]');
  var nameExpression = RegExp('[^a-z A-Z]');

  Future<void> signInWithGoogle(
      String firstName, String lastName, String phone, String userType) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await auth.signInWithCredential(authCredential);
      if (result.additionalUserInfo?.isNewUser == true) {
        final User? user = auth.currentUser;
        final uid = user?.uid;
        final email = user?.email;

        dataBox = Hive.box('storage');
        await dataBox.put('firstName', firstName);
        await dataBox.put('lastName', lastName);
        await dataBox.put('phone', phone);
        await dataBox.put(
          'userType',
          userType,
        );
        await dataBox.put('uid', uid);
        await dataBox.put('email', email);

        if (selectedType.name == 'trainee') {
          print("registersucessfull");

          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 250),
                  child: const AgeScreen()));
        } else {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 250),
                  child: const GenderPage()));
        }
      } else {
        SnackBar snackBar = SnackBar(
          padding: const EdgeInsets.all(20),
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 2),
          content: Text(
            "User already exist for this gmail.",
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
    }
  }

  @override
  void initState() {
    super.initState();
    firstNameController.text = '';
    lastNameController.text = '';
    phoneController.text = '';
  }

  late AccountType selectedType = AccountType.trainee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        resizeToAvoidBottomInset: false,
        // ignore: sized_box_for_whitespace
        body: SafeArea(
          child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 25, right: 25, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Create an Account",
                          style: GoogleFonts.montserrat(
                            height: .5,
                            letterSpacing: 0.5,
                            fontSize: 16,
                            color: Color.fromARGB(255, 125, 128, 122),
                          ),
                        ),
                        Form(
                            key: formGlobalKey,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 30, bottom: 12, left: 5, right: 5),
                                  child: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                      FilteringTextInputFormatter.deny(
                                          nameExpression),
                                    ],
                                    keyboardType: TextInputType.text,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    controller: firstNameController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 39, 48, 81),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      hintText: "First Name",
                                      errorStyle: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.red,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 39, 48, 81),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.account_circle_outlined,
                                        size: 20,
                                        color:
                                            Color.fromRGBO(142, 153, 183, 0.5),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 12, left: 5, right: 5),
                                  child: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                      FilteringTextInputFormatter.deny(
                                          nameExpression),
                                    ],
                                    // validator: (val) {
                                    //   if (val == "") return 'Enter Last Name';
                                    // },

                                    keyboardType: TextInputType.text,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    controller: lastNameController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 39, 48, 81),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      hintText: "Last Name",
                                      errorStyle: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.red,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 39, 48, 81),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.account_circle_outlined,
                                        size: 20,
                                        color:
                                            Color.fromRGBO(142, 153, 183, 0.5),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 12, left: 5, right: 5),
                                  child: TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10),
                                        FilteringTextInputFormatter.deny(
                                            phoneExpression),
                                      ],
                                      keyboardType: TextInputType.phone,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                      controller: phoneController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 39, 48, 81),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        hintText: "Phone",
                                        errorStyle: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.red,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 39, 48, 81),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.phone_android_outlined,
                                          size: 20,
                                          color: Color.fromRGBO(
                                              142, 153, 183, 0.5),
                                        ),
                                      )),
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Account Type",
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(142, 153, 183, 0.5),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedType = AccountType.trainee;
                                  });
                                },
                                child: AccountTypeCard(
                                    cardTitle: "Trainee",
                                    cardBorder:
                                        selectedType == AccountType.trainee
                                            ? 2
                                            : 0,
                                    cardImg: "assets/trainee.png"),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedType = AccountType.trainer;
                                  });
                                },
                                child: AccountTypeCard(
                                    cardTitle: "Trainer",
                                    cardBorder:
                                        selectedType == AccountType.trainer
                                            ? 2
                                            : 0,
                                    cardImg: "assets/trainer.png"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "By creating your acount, you are agreeing to our",
                          style: GoogleFonts.montserrat(
                            letterSpacing: .4,
                            fontSize: 10,
                            color: Colors.black.withOpacity(.65),
                          ),
                        ),
                        Text(
                          "Terms and Services",
                          style: GoogleFonts.montserrat(
                            height: 1.4,
                            letterSpacing: .4,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        BlocConsumer<RegisterCubit, RegisterState>(
                            listener: (context, state) {
                          if (state is RegisterFirstNameErrorState) {
                            SnackBar snackBar = SnackBar(
                              padding: const EdgeInsets.all(20),
                              backgroundColor: Colors.white,
                              duration: const Duration(seconds: 2),
                              content: Text(
                                state.errorMessage,
                                style: GoogleFonts.montserrat(
                                  height: .5,
                                  letterSpacing: 0.5,
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (state is RegisterLastNameErrorState) {
                            SnackBar snackBar = SnackBar(
                              padding: const EdgeInsets.all(20),
                              backgroundColor: Colors.white,
                              duration: const Duration(seconds: 2),
                              content: Text(
                                state.errorMessage,
                                style: GoogleFonts.montserrat(
                                  height: .5,
                                  letterSpacing: 0.5,
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (state is RegisterPhoneErrorState) {
                            SnackBar snackBar = SnackBar(
                              padding: const EdgeInsets.all(20),
                              backgroundColor: Colors.white,
                              duration: const Duration(seconds: 2),
                              content: Text(
                                state.errorMessage,
                                style: GoogleFonts.montserrat(
                                  height: .5,
                                  letterSpacing: 0.5,
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (state is RegisterValidState) {
                            signInWithGoogle(
                                firstNameController.text,
                                lastNameController.text,
                                phoneController.text,
                                selectedType.name);

                            // Navigator.push(
                            //     context,
                            //     PageTransition(
                            //         type: PageTransitionType.fade,
                            //         duration: const Duration(milliseconds: 250),
                            //         child: const AgeScreen()));

                            // SnackBar snackBar = SnackBar(
                            //   padding: const EdgeInsets.all(20),
                            //   backgroundColor: Colors.white,
                            //   duration: const Duration(seconds: 2),
                            //   content: Text(
                            //     "Yay you can register",
                            //     style: GoogleFonts.montserrat(
                            //       height: .5,
                            //       letterSpacing: 0.5,
                            //       fontSize: 12,
                            //       color: Colors.black,
                            //     ),
                            //   ),
                            // );
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(snackBar);
                          }
                        }, builder: (context, state) {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: const FaIcon(
                                FontAwesomeIcons.google,
                                size: 16,
                                color: Colors.black,
                              ),
                              label: Text(
                                "Register  With Google",
                                style: GoogleFonts.notoSansMono(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              onPressed: () async {
                                BlocProvider.of<RegisterCubit>(context)
                                    .validate(
                                        firstNameController.text,
                                        lastNameController.text,
                                        phoneController.text);
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  textStyle: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have a account? ",
                              style: GoogleFonts.montserrat(
                                letterSpacing: .4,
                                fontSize: 11,
                                color: Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(.65),
                              ),
                            ),
                            GestureDetector(
                              child: Text(
                                "Login",
                                style: GoogleFonts.montserrat(
                                  letterSpacing: .4,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 25, 170, 151),
                                ),
                              ),
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: const LoginScreen()));
                              },
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )),
        ));
  }
}

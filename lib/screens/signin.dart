import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/screens/mainscreen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Stack(
          children: [
            Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.srgbToLinearGamma(),
                    image: AssetImage("assets/login.jpg"),
                    fit: BoxFit.cover,
                  ),
                )),
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sign In",
                      style: GoogleFonts.roboto(
                          letterSpacing: .5,
                          height: 1,
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold)),
                  Form(
                      child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Column(
                      children: [
                        TextFormField(
                            strutStyle: const StrutStyle(height: 1.5),
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                labelText: 'Email',
                                focusColor: Colors.white,
                                labelStyle: TextStyle(color: Colors.white)),
                            style: GoogleFonts.roboto(
                                height: 1,
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.normal)),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                            obscureText: true,
                            strutStyle: const StrutStyle(height: 1.5),
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                labelText: 'Password',
                                focusColor: Colors.white,
                                labelStyle: TextStyle(color: Colors.white)),
                            style: GoogleFonts.roboto(
                                height: 1,
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.normal)),
                      ],
                    ),
                  )),
                  const SizedBox(
                    height: 75,
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen())),
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 66, 116, 255),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.merriweather(
                            color: Colors.white,
                            letterSpacing: .5,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: null,
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.roboto(
                          height: 1,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Don't have a account?",
                      style: GoogleFonts.roboto(
                          height: 1,
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen())),
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.mandali(
                            height: 1,
                            color: const Color.fromARGB(255, 66, 116, 255),
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
              )),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainScreen())),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: const Color.fromARGB(255, 255, 234, 194),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            textStyle: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        child: Text(
                          "Sign In With Google",
                          style: GoogleFonts.ubuntu(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                ))
          ],
        )));
  }
}

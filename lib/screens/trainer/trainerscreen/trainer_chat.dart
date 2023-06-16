import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  DateTime date = DateTime.now();
  String? week;
  String? day;
  String? month;
  @override
  void initState() {
    setState(() {
      week = DateFormat('EEEE').format(date);
      day = DateFormat('d').format(date);
      month = DateFormat('MMMM').format(date);
    });
    super.initState();
  }
  //list of premium users

  final List<Widget> customers = [const Text('addarsh'), const Text("Sagar")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        elevation: 0,
        title: Text("CHAT HISTORY",
            style: GoogleFonts.montserrat(
                letterSpacing: .5,
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600)),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: ((context, index) {
            return Container(
              child: GestureDetector(
                onTap: () {},
                child: Card(
                  elevation: 15,
                  color: Color.fromARGB(255, 114, 97, 89),
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 15)),
                      const CircleAvatar(
                        backgroundImage: AssetImage("assets/male.png"),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(25),
                          child: customers[index]),
                    ],
                  ),
                ),
              ),
            );
          }),
          itemCount: customers.length,
        ),
      ),
    );
  }
}

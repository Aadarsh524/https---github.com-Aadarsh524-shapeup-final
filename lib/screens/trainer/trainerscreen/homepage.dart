import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shapeup/screens/trainer/trainerscreen/traineesprofile.dart';
import 'package:shapeup/screens/trainer/trainerscreen/trainerprofile.dart';

class HomePageT extends StatefulWidget {
  const HomePageT({Key? key}) : super(key: key);

  @override
  State<HomePageT> createState() => _HomePageTState();
}

class _HomePageTState extends State<HomePageT> {
  String? week;
  String? day;
  String? month;
  DateTime date = DateTime.now();
  //list of premium user
  final List<Widget> customers = [
    const Text('Trainee1'),
    const Text(
      "Trainee2",
    )
  ];
  @override
  void initState() {
    setState(() {
      week = DateFormat('EEEE').format(date);
      day = DateFormat('d').format(date);
      month = DateFormat('MMMM').format(date);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(50)),
                        child: InkWell(
                          onTap: () {
                            // Get.to(() => const TrainerProfile(),
                            //     transition: Transition.circularReveal,
                            //     duration: const Duration(seconds: 1));
                          },
                          child: IconButton(
                            color: const Color.fromARGB(255, 190, 227, 57),
                            iconSize: 24,
                            padding: const EdgeInsets.all(0),
                            icon: const Icon(Icons.person_outlined),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TrainerProfile()));
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hey, Bibash", //firebase trainer name
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  color: Color.fromARGB(255, 190, 227, 57),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(
                            height: 3,
                          ),
                          Text("$week, $day $month",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Container(
                //         padding: const EdgeInsets.fromLTRB(30, 20, 10, 20),
                //         child: Text(
                //           '“The body achieves what \nthe mind believes.”\n-– Napoleon Hill ',
                //           textAlign: TextAlign.justify,
                //           style: GoogleFonts.montserrat(
                //               color: Colors.white,
                //               fontSize: 20,
                //               fontWeight: FontWeight.w600),
                //         )),
                //     const SizedBox(
                //       height: 40,
                //     ),
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 20, 30, 10),
                  child: Text(
                    'Trainees List',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: Color.fromARGB(255, 190, 227, 57),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      return Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TraineeProfile()));
                          },
                          child: Card(
                            elevation: 15,
                            color: Color.fromARGB(255, 114, 97, 89),
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(left: 15)),
                                const CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/male.png"),
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
              ],
            ),
          ),
        ));
  }
}

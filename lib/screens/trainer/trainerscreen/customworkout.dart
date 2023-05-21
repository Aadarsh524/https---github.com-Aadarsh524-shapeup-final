import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateWork extends StatefulWidget {
  const UpdateWork({Key? key}) : super(key: key);

  @override
  State<UpdateWork> createState() => _UpdateWorkState();
}

class _UpdateWorkState extends State<UpdateWork> {
  //variables
  final _newNameController = TextEditingController();
  final _newDescController = TextEditingController();
  final _newDuraController = TextEditingController();
  final _newRepsController = TextEditingController();
  
  int _val = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 28, 28, 30),
          title: Text('Update Workout',
              style: GoogleFonts.montserrat(
                  letterSpacing: .5,
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600)),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // DropdownButtonFormField(
                //     decoration: InputDecoration(labelText: 'Day'),
                //     dropdownColor: const Color.fromARGB(255, 114, 97, 89),
                //     value: _selectedVal,
                //     items: _days.map((e) {
                //       return DropdownMenuItem(
                //         child: Text(e),
                //         value: e,
                //       );
                //     }).toList(),
                //     onChanged: (val) {
                //       setState(() {
                //         _selectedVal = val as String;
                //       });
                //     }),

                Container(
                  margin: const EdgeInsets.only(bottom: 12, left: 5, right: 5),
                  child: TextFormField(
                    onChanged: (val) {},
                    keyboardType: TextInputType.name,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                    controller: _newNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 39, 48, 81),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Name",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 39, 48, 81),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      prefixIcon: const Icon(
                        Icons.run_circle,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 12, left: 5, right: 5),
                  padding:
                      EdgeInsets.only(left: 14, right: 7, top: 7, bottom: 7),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: .5,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Workout Type',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      Radio(
                          value: 1,
                          groupValue: _val,
                          onChanged: (value) {
                            setState(() {
                              _val = value as int;
                            });
                          }),
                      SizedBox(
                        child: Text(
                          'Duration',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Radio(
                          value: 2,
                          groupValue: _val,
                          onChanged: (value) {
                            setState(() {
                              _val = value as int;
                            });
                          }),
                      SizedBox(
                        child: Text(
                          'Reps',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 12, left: 5, right: 5),
                  child: SizedBox(
                    child: _val == 1
                        ? TextFormField(
                            onChanged: (val) {},
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                            controller: _newDuraController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 39, 48, 81),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: "Duration",
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 39, 48, 81),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              prefixIcon: const Icon(
                                Icons.timer,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : TextFormField(
                            onChanged: (val) {},
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                            controller: _newRepsController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 39, 48, 81),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: "Number of reps",
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 39, 48, 81),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              prefixIcon: const Icon(
                                Icons.numbers_sharp,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(bottom: 12, left: 5, right: 5),
                  child: TextField(
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
                      hintText: "Workout Description",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 39, 48, 81),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      prefixIcon: const Icon(
                        Icons.description_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(
                          255,
                          208,
                          253,
                          62,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Next',
                        style: GoogleFonts.notoSansMono(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: FloatingActionButton.extended(
              onPressed: () {},
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
                      'Add Workout',
                      style: GoogleFonts.notoSansMono(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )),
        ));
  }
}

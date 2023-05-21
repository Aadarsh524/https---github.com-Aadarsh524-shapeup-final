import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shapeup/screens/trainer/trainerRegister/agescreen.dart';


class Gender {
  String name;
  IconData icon;
  bool isSelected;

  Gender(this.name, this.icon, this.isSelected);
}

// ignore: must_be_immutable
class CustomRadio extends StatelessWidget {
  Gender _gender;

  CustomRadio(this._gender);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 152,
        width: 152,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
            color: _gender.isSelected
                ? const Color.fromARGB(
                    255,
                    208,
                    253,
                    62,
                  )
                : const Color.fromARGB(255, 44, 44, 46),
            child: Container(
              height: 152,
              width: 152,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    _gender.icon,
                    color: _gender.isSelected ? Colors.black : Colors.white,
                    size: 80,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _gender.name,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        color:
                            _gender.isSelected ? Colors.black : Colors.white),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

class GenderPage extends StatefulWidget {
  const GenderPage({Key? key}) : super(key: key);

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  List<Gender> genders = [
    Gender("Male", MdiIcons.genderMale, false),
    Gender("Female", MdiIcons.genderFemale, false)
  ];
  @override
  void initState() {
    super.initState();
    // genders.add(new Gender("Male", MdiIcons.genderMale, false));
    // genders.add(new Gender("Female", MdiIcons.genderFemale, false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 30),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              'TELL US ABOUT YOURSELF!',
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 80,
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: genders.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        genders.forEach((gender) => gender.isSelected = false);
                        genders[index].isSelected = true;
                      });
                    },
                    child: CustomRadio(genders[index]),
                  );
                }),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AgePicker()));
            },
            backgroundColor: const Color.fromARGB(
              255,
              208,
              253,
              62,
            ),
            label: SizedBox(
                child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  Text(
                    'Next',
                    style: GoogleFonts.montserrat(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                  )
                ],
              ),
            ))),
      ),
    );
  }
}

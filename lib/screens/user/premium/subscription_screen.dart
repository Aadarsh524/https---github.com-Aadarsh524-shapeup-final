import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:shapeup/models/subscription_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/user/userDashboard/dashboardscreen.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

User? user = FirebaseAuth.instance.currentUser;
final userId = FirebaseAuth.instance.currentUser?.uid;

class _SubscriptionPageState extends State<SubscriptionPage> {
  late final Box dataBox;
  User? user = FirebaseAuth.instance.currentUser;
  final userId = FirebaseAuth.instance.currentUser?.uid;
  late bool premium;
  String? date;
  DateTime subsDate = DateTime.now();
  var newDate;

  List<SubscriptionModel> subscriptionPlans = [
    SubscriptionModel(
        title: 'Monthly', price: 199, time: "1", isSelected: false),
    SubscriptionModel(
        title: 'Quaterly', price: 499, time: "3", isSelected: false),
    SubscriptionModel(
        title: 'Yearly', price: 1799, time: "12", isSelected: false),
  ];

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('storage');
    premium = dataBox.get("premium");
    newDate = DateTime(subsDate.year, subsDate.month + 1, subsDate.day);
    date = DateFormat('MMMd').format(newDate);
    subscriptionPlans[0].isSelected = true;
    setState(() {
      selectedIndex = 0;
    });
    print(selectedIndex);
    getAmt(selectedIndex);
    print(getAmt(selectedIndex));
  }

  late int selectedIndex;

  List<String> includedList = [
    'Ad-free UI',
    'Macros information',
    'Access to in-app personal trainer',
    'More exercise and diet plans',
    'Chat interface with your trainer'
  ];

  int getAmt(int index) {
    index = selectedIndex;

    return subscriptionPlans[index].price * 100;
    //returns the amount to be payed in paisa
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            toolbarHeight: 60,
            centerTitle: true,
            title: Text("Premium",
                style: GoogleFonts.montserrat(
                    letterSpacing: .5,
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600)),
            backgroundColor: Color.fromARGB(255, 28, 28, 30),
            elevation: 0.0,
            leading: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 114, 97, 89),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: IconButton(
                      color: Colors.black,
                      iconSize: 12,
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            )),
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 20, right: 20, bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            'You will get access to:',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 190, 227, 57)),
                          ),
                        ),
                        ListView.builder(
                          itemCount: includedList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => ListTile(
                            leading: const Icon(
                              Icons.check_circle_outline,
                              color: Color.fromARGB(255, 166, 181, 106),
                            ),
                            title: Text(
                              includedList[index],
                              style: GoogleFonts.montserrat(
                                height: .5,
                                letterSpacing: 0.5,
                                fontSize: 12,
                                color: Color.fromARGB(255, 166, 181, 106),
                              ),
                            ),
                            contentPadding:
                                const EdgeInsets.only(left: 20, right: 10),
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
                            minVerticalPadding: 0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: subscriptionPlans.length,
                      itemBuilder: (context, index) => Card(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: subscriptionPlans[index].isSelected == true
                                  ? Colors.red
                                  : Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 0.0,
                        color: const Color.fromARGB(255, 36, 37, 35),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: CheckboxListTile(
                          value: subscriptionPlans[index].isSelected,
                          onChanged: (val) {
                            for (var element in subscriptionPlans) {
                              setState(() {
                                element.isSelected = false;
                              });
                            }
                            setState(() {
                              subscriptionPlans[index].isSelected = true;
                              selectedIndex = index;
                              print(getAmt(selectedIndex));
                            });
                          },
                          activeColor: const Color.fromARGB(255, 25, 170,
                              151), // Change the color of the checkbox when checked
                          checkColor: Colors.white,
                          controlAffinity: ListTileControlAffinity.leading,
                          visualDensity: const VisualDensity(vertical: -3),
                          contentPadding:
                              const EdgeInsets.only(left: 8, right: 8),
                          title: Text(
                            subscriptionPlans[index].title,
                            style: GoogleFonts.montserrat(
                              height: 2,
                              letterSpacing: 0.5,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          secondary: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              "Rs. ${subscriptionPlans[index].price}",
                              style: GoogleFonts.montserrat(
                                height: 2,
                                letterSpacing: 0.5,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          subtitle: Text(
                            "Renew in ${subscriptionPlans[index].time} month",
                            style: GoogleFonts.montserrat(
                              height: .5,
                              letterSpacing: 0.5,
                              fontSize: 10,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              final amount = getAmt(selectedIndex);
              print(amount);
              if (amount == null) {
                SnackBar errorSnackBar = SnackBar(
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.white,
                  duration: const Duration(seconds: 2),
                  content: Text(
                    "Please selected a plan to continue.",
                    style: GoogleFonts.montserrat(
                      height: .5,
                      letterSpacing: 0.5,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                return;
              }
              KhaltiScope.of(context).pay(
                config: PaymentConfig(
                  amount: getAmt(selectedIndex),
                  productIdentity: 'dells-sssssg5-g5510-2021',
                  productName: 'Product Name',
                ),
                preferences: [
                  PaymentPreference.khalti,
                ],
                onSuccess: (su) async => {
                  premium = true,
                  dataBox
                      .put('premium', premium)
                      .then((value) => FirebaseFirestore.instance
                              .collection('users')
                              .doc(user?.uid)
                              .update({
                            'premium': true,
                          }))
                      .then((value) => Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 300),
                              child: const DashBoardScreen())))
                      .then((value) => Future(() {
                            SnackBar successsnackBar = SnackBar(
                              padding: const EdgeInsets.all(20),
                              backgroundColor: Colors.white,
                              duration: const Duration(seconds: 2),
                              content: Text(
                                "Payment Success",
                                style: GoogleFonts.montserrat(
                                  height: .5,
                                  letterSpacing: 0.5,
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(successsnackBar);
                          }))
                      .then((value) => Future(() {
                            SnackBar successsnackBar = SnackBar(
                              padding: const EdgeInsets.all(20),
                              backgroundColor: Colors.white,
                              duration: const Duration(seconds: 2),
                              content: Text(
                                "Now you can proceed to trainer selection.",
                                style: GoogleFonts.montserrat(
                                  height: .5,
                                  letterSpacing: 0.5,
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(successsnackBar);
                          }))
                },
                onFailure: (fa) {
                  SnackBar failedSnackBar = SnackBar(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.white,
                    duration: const Duration(seconds: 2),
                    content: Text(
                      "Payment Failed",
                      style: GoogleFonts.montserrat(
                        height: .5,
                        letterSpacing: 0.5,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(failedSnackBar);
                },
                onCancel: () {
                  SnackBar cancelledSnackBar = SnackBar(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.white,
                    duration: const Duration(seconds: 2),
                    content: Text(
                      "Payment Failed",
                      style: GoogleFonts.montserrat(
                        height: .5,
                        letterSpacing: 0.5,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(cancelledSnackBar);
                },
              );
            },
            backgroundColor: const Color.fromARGB(255, 166, 181, 106),
            label: Text(
              'Buy Premium',
              style: GoogleFonts.notoSansMono(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            )));
  }
}

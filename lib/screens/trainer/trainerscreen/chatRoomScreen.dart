import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/trainer/trainerscreen/trainer_chat_screen.dart';
import 'package:shapeup/services/chat_service.dart';
import '../../../models/chat_room_model.dart';
import '../../../models/trainee_profile_model.dart';
import '../../../services/traineeprofileservice.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({Key? key}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 30),
      body: Stack(
        children: <Widget>[
          FutureBuilder<List<ChatRoomModel>>(
            future: ChatService().chatRoomList(user!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              final chatRoomList = snapshot.data;

              return ListView.builder(
                itemCount: chatRoomList!.length,
                itemBuilder: (BuildContext context, int index) {
                  final chatRoom = chatRoomList[index];
                  return FutureBuilder<TraineeProfileModel?>(
                    future: TraineeProfileService()
                        .traineeProfile(chatRoom.trainee),
                    builder: (context, traineeSnapshot) {
                      if (traineeSnapshot.hasError) {
                        return Text('Error: ${traineeSnapshot.error}');
                      }

                      if (traineeSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      final traineeProfile = traineeSnapshot.data;

                      return Container(
                        padding: const EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: const Duration(milliseconds: 250),
                                    child: TrainerChatScreen(
                                        chatRoomID: snapshot.data![index].id,
                                        traineeID: traineeProfile!.id)));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 85,
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Card(
                              elevation: 5,
                              color: const Color.fromARGB(255, 114, 97, 89),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        child: Image.network(
                                            height: 65,
                                            width: 65,
                                            fit: BoxFit.contain,
                                            traineeProfile!.userImage),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                              "${traineeProfile.firstName} ${traineeProfile.lastName} ",
                                              style: GoogleFonts.montserrat(
                                                  letterSpacing: .5,
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

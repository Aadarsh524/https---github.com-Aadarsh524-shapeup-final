import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:shapeup/services/chat/chat_service.dart';

import '../../../models/chat/chat_model.dart';
import '../../../models/profile/trainee_profile_model.dart';
import '../../../services/profile/trainee_profile_service.dart';

class TrainerChatScreen extends StatefulWidget {
  final String chatRoomID;
  final String traineeID;
  const TrainerChatScreen(
      {Key? key, required this.chatRoomID, required this.traineeID})
      : super(key: key);

  @override
  State<TrainerChatScreen> createState() => _TrainerChatScreenState();
}

class _TrainerChatScreenState extends State<TrainerChatScreen> {
  late final Box dataBox;
  late String firstName;
  late String lastName;
  late String userImage;
  late String myTrainer;
  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('storage');
    firstName = dataBox.get("firstName").toString();
    lastName = dataBox.get("lastName").toString();
    userImage = dataBox.get('userImage').toString();
    myTrainer = dataBox.get('myTrainer').toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 30),
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: const Color.fromARGB(255, 174, 155, 141),
              height: 1.0,
            )),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 28, 28, 30),
        flexibleSpace: SafeArea(
          child: FutureBuilder<TraineeProfileModel?>(
              future: TraineeProfileService().traineeProfile(widget.traineeID),
              builder: (BuildContext context, snapshot) {
                final traineeProfile = snapshot.data;

                if (snapshot.hasError) {
                  return const Center(child: Text("Something went wrong"));
                }
                if (snapshot.hasData) {
                  return Container(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: Image.network(
                              fit: BoxFit.fill,
                              traineeProfile!.userImage,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  "${traineeProfile.firstName} ${traineeProfile.lastName}",
                                  style: GoogleFonts.montserrat(
                                      letterSpacing: .5,
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  ));
                }
              }),
        ),
      ),
      body: Stack(
        children: <Widget>[
          StreamBuilder<List<ChatMessageModel>>(
            stream: ChatService().chatMessageStream(widget.chatRoomID),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                final messagesList = snapshot.data;

                return ListView.builder(
                  itemCount: messagesList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final message = messagesList[index];
                    return Container(
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (message.sender == user!.uid
                            ? Alignment.topRight
                            : Alignment.topLeft),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (message.sender == user!.uid
                                ? Colors.blue[200]
                                : Colors.grey.shade200),
                          ),
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 8, bottom: 8),
                          child: Text(
                            message.messageContent,
                            style: GoogleFonts.montserrat(
                                letterSpacing: .5,
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Text("No data");
              }
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      String sender = user!.uid;
                      String receiver = myTrainer;

                      String messageContent = _textEditingController.text;

                      ChatService().sendChatMessage(
                          messageContent, widget.chatRoomID, sender, receiver);
                      _textEditingController.clear();
                    },
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/chat/chat_model.dart';
import '../../models/chat/chat_room_model.dart';

class ChatService {
  final CollectionReference chatscollection =
      FirebaseFirestore.instance.collection('chatrooms');

  List<ChatMessageModel> _chatMessageFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final timestamp = doc['timestamp'] != null
          ? (doc['timestamp'] as Timestamp).toDate()
          : null;
      return ChatMessageModel(
        messageContent: doc['messageContent'] ?? '',
        sender: doc['sender'] ?? '',
        receiver: doc['receiver'] ?? '',
        timestamp: timestamp!,
      );
    }).toList();
  }

  Stream<List<ChatMessageModel>> chatMessageStream(chatRoomID) {
    return chatscollection
        .doc(chatRoomID)
        .collection('chats')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) {
      return _chatMessageFromSnapshot(snapshot);
    });
  }

  Future<DocumentSnapshot<Object?>> chatRoomsStream(chatRoomID) async {
    final documentSnapshot = await chatscollection.doc(chatRoomID).get();
    return documentSnapshot;
  }

  List<ChatRoomModel> _chatRoomsFromSnapshot(
      QuerySnapshot snapshot, String trainerID) {
    return snapshot.docs
        .map((doc) {
          final timestamp = doc['timestamp'] != null
              ? (doc['timestamp'] as Timestamp).toDate()
              : null;
          return ChatRoomModel(
            id: doc.id,
            trainer: doc['trainer'],
            trainee: doc['trainee'] ?? '',
            timestamp: timestamp!,
          );
        })
        .where((chatRoom) => chatRoom.trainer == trainerID)
        .toList();
  }

  Future<List<ChatRoomModel>> chatRoomList(trainerID) async {
    final snapshot = await chatscollection.get();
    return _chatRoomsFromSnapshot(snapshot, trainerID);
  }

  void sendChatMessage(String messageContent, String chatRoomID, String sender,
      String receiver) async {
    if (messageContent.isNotEmpty) {
      Map<String, dynamic> message = {
        "sender": sender,
        "receiver": receiver,
        "messageContent": messageContent,
        "timestamp": Timestamp.now(),
      };
      chatscollection.doc(chatRoomID).collection('chats').add(message);
    } else {}
  }
}

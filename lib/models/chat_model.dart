class ChatMessageModel {
  String messageContent;
  String sender;
  String receiver;
  DateTime timestamp;

  ChatMessageModel({
    required this.messageContent,
    required this.sender,
    required this.receiver,
    required this.timestamp,
  });
}

class ChatRoomModel {
  String trainer;
  String trainee;
  String id;

  DateTime timestamp;
  ChatRoomModel(
      {required this.trainer,
      required this.id,
      required this.trainee,
      required this.timestamp});
}

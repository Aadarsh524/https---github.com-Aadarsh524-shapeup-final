class ChatRoomModel {
  String trainer;
  String trainee;
  String id;

  String timeStamp;
  ChatRoomModel(
      {required this.trainer,
      required this.id,
      required this.trainee,
      required this.timeStamp});
}

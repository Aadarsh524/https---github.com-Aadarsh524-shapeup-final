import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shapeup/models/notification_model.dart';

class NotificationServices {
  final String? uID;
  NotificationServices({this.uID});

  final CollectionReference notificationCollection =
      FirebaseFirestore.instance.collection('notifications');

  List<NotificationModel> notificationList(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => NotificationModel(
              message: doc['message'] ?? '',
            ))
        .toList();
  }

  Stream<List<NotificationModel>> get getNotification {
    return notificationCollection
        .doc(uID)
        .collection("list")
        .snapshots()
        .map(notificationList);
  }
}

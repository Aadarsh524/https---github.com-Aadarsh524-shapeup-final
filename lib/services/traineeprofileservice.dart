import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:shapeup/screens/user/notification/notificationscreen.dart';

import '../models/trainee_profile_model.dart';

class TraineeProfileService {
  User? users = FirebaseAuth.instance.currentUser;
  final userId = FirebaseAuth.instance.currentUser?.uid;
  
  TraineeProfileService();
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<List<TraineeProfileModel>> get traineeProfileList async {
    final snapshot = await usersCollection.get();
    return _traineeProfileListFromSnapshot(snapshot);
  }

  List<TraineeProfileModel> _traineeProfileListFromSnapshot(
      QuerySnapshot snapshot) {
    List<TraineeProfileModel> traineeProfiles = [];

    for (var doc in snapshot.docs) {
      if (doc.get('userType') == 'trainee' && doc.get('mytrainer') == userId) {
        TraineeProfileModel traineeProfile = TraineeProfileModel(
          email: doc.get("email") ?? '',
          firstName: doc.get('firstName') ?? '',
          lastName: doc.get('lastName') ?? '',
          age: doc.get('age') ?? '',
          gender: doc.get('gender') ?? '',
          userType: doc.get('userType') ?? '',
          phone: doc.get('phone') ?? '',
          userImage: doc.get('userImage'),
          id: doc.id,
          height: doc.get("height") ?? '',
          weight: doc.get("weight") ?? '',
          bmi: doc.get("bmi") ?? '',
        );
        traineeProfiles.add(traineeProfile);
      }
    }
    return traineeProfiles;
  }

  Future<TraineeProfileModel?> traineeProfile(String docID) async {
    final docRef = usersCollection.doc(docID);
    final snapshot = await docRef.get();
    return _traineeProfileFromSnapshot(snapshot);
  }

  TraineeProfileModel? _traineeProfileFromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      TraineeProfileModel traineeProfile = TraineeProfileModel(
        email: snapshot.get("email") ?? '',
        firstName: snapshot.get('firstName') ?? '',
        lastName: snapshot.get('lastName') ?? '',
        age: snapshot.get('age') ?? '',
        gender: snapshot.get('gender') ?? '',
        userType: snapshot.get('userType') ?? '',
        phone: snapshot.get('phone') ?? '',
        userImage: snapshot.get('userImage'),
        id: snapshot.id,
        height: snapshot.get("height") ?? '',
        weight: snapshot.get("weight") ?? '',
        bmi: snapshot.get("bmi") ?? '',
      );
      return traineeProfile;
    }
    return null;
  }
}

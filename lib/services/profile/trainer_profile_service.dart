import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/profile/trainer_profile_model.dart';

class TrainerProfileService {
  TrainerProfileService();
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<List<TrainerProfileModel>> get trainerProfileList async {
    final snapshot = await usersCollection.get();
    return _trainerProfileListFromSnapshot(snapshot);
  }

  List<TrainerProfileModel> _trainerProfileListFromSnapshot(
      QuerySnapshot snapshot) {
    List<TrainerProfileModel> trainerProfiles = [];

    for (var doc in snapshot.docs) {
      if (doc.get('userType') == 'trainer' &&
          doc.get('isVerified').toString() == 'true') {
        TrainerProfileModel trainerProfile = TrainerProfileModel(
            email: doc.get("email") ?? '',
            firstName: doc.get('firstName') ?? '',
            lastName: doc.get('lastName') ?? '',
            age: doc.get('age') ?? '',
            gender: doc.get('gender') ?? '',
            descrp: doc.get('descrp') ?? '',
            userType: doc.get('userType') ?? '',
            phone: doc.get('phone') ?? '',
            userImage: doc.get('userImage'),
            expage: doc.get('expage') ?? '',
            deviceToken: doc.get('deviceToken') ?? '',
            id: doc.id,
            clients: doc.get('clients'));
        trainerProfiles.add(trainerProfile);
      }
    }
    return trainerProfiles;
  }

  Future<TrainerProfileModel> trainerProfile(String docID) async {
    print(docID);
    final docRef = usersCollection.doc(docID);
    final snapshot = await docRef.get();
    return _trainerProfileFromSnapshot(snapshot);
  }

  TrainerProfileModel _trainerProfileFromSnapshot(DocumentSnapshot snapshot) {
    TrainerProfileModel trainerProfile = TrainerProfileModel(
        email: snapshot.get("email") ?? '',
        firstName: snapshot.get('firstName') ?? '',
        lastName: snapshot.get('lastName') ?? '',
        age: snapshot.get('age') ?? '',
        gender: snapshot.get('gender') ?? '',
        descrp: snapshot.get('descrp') ?? '',
        userType: snapshot.get('userType') ?? '',
        phone: snapshot.get('phone') ?? '',
        userImage: snapshot.get('userImage'),
        expage: snapshot.get('expage') ?? '',
        deviceToken: snapshot.get('deviceToken') ?? '',
        id: snapshot.id,
        clients: snapshot.get('clients'));
    return trainerProfile;
  }
}

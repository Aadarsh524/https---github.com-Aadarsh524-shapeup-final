import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shapeup/models/exercise/exercise_detail_model.dart';
import 'package:shapeup/models/exercise/exercise_model.dart';

import '../../models/exercise/custom_exercise_model.dart';

class ExerciseService {
  final String? docID;
  final int? dayindex;

  ExerciseService({this.docID, this.dayindex});

  final CollectionReference exercisecollection =
      FirebaseFirestore.instance.collection('exercise');

  final CollectionReference allexercisecollection =
      FirebaseFirestore.instance.collection('allexercises');

  final CollectionReference customcollection =
      FirebaseFirestore.instance.collection('exercises');

  final CollectionReference usercollection =
      FirebaseFirestore.instance.collection('userSpecific');

  final CollectionReference customcollectionfromTrainer =
      FirebaseFirestore.instance.collection('userSpecific');

  Future<CustomExerciseModel?> premiumPlans(String docID) async {
    final docRef = customcollection.doc(docID);
    final snapshot = await docRef.get();
    return premiumPlansFromSnapshot(snapshot);
  }

  CustomExerciseModel? premiumPlansFromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      CustomExerciseModel customExerciseModel = CustomExerciseModel(
        id: snapshot.id,
        planName: snapshot.get('planName') ?? '',
        description: snapshot.get('description') ?? '',
        level: snapshot.get('level') ?? '',
        exerciseDuration: snapshot.get('exerciseDuration') ?? '',
        createBy: snapshot.get('createBy') ?? '',
      );
      return customExerciseModel;
    }
    return null;
  }

  List<CustomExerciseModel> _customExerciseFromSnapshot(
      QuerySnapshot snapshot) {
    List<CustomExerciseModel> customExerciseModel = [];

    for (var doc in snapshot.docs) {
      CustomExerciseModel customModel = CustomExerciseModel(
        id: doc.id,
        planName: doc['planName'] ?? '',
        description: doc['description'] ?? '',
        level: doc['level'] ?? '',
        exerciseDuration: doc['exerciseDuration'] ?? '',
        createBy: doc['createBy'] ?? '',
      );
      customExerciseModel.add(customModel);
    }
    return customExerciseModel;
  }

  Future<List<CustomExerciseModel>> get customExerciseList async {
    final snapshot = await customcollection.get();
    return _customExerciseFromSnapshot(snapshot);
  }

  Future<List<CustomExerciseModel>> getPurchasedPlanIDs(String uid) async {
    final snapshot = await customcollection.get();
    return _getPurchasedPlanIDsFromSnapshot(snapshot);
  }

  List<CustomExerciseModel> _getPurchasedPlanIDsFromSnapshot(
      QuerySnapshot snapshot) {
    List<CustomExerciseModel> customExerciseModel = [];

    for (var doc in snapshot.docs) {
      CustomExerciseModel customModel = CustomExerciseModel(
        id: doc.id,
        planName: doc['planName'] ?? '',
        description: doc['description'] ?? '',
        level: doc['level'] ?? '',
        exerciseDuration: doc['exerciseDuration'] ?? '',
        createBy: doc['createBy'] ?? '',
      );
      customExerciseModel.add(customModel);
    }
    return customExerciseModel;
  }

  Future<List<CustomExerciseModel>> get customPlanList async {
    final snapshot = await customcollection.get();
    return _customPlanFromSnapshot(snapshot);
  }

  List<CustomExerciseModel> _customPlanFromSnapshot(QuerySnapshot snapshot) {
    User? users = FirebaseAuth.instance.currentUser;
    List<CustomExerciseModel> customExerciseModel = [];

    for (var doc in snapshot.docs) {
      if (doc['createBy'] == users!.uid) {
        CustomExerciseModel customModel = CustomExerciseModel(
          id: doc.id,
          planName: doc['planName'] ?? '',
          description: doc['description'] ?? '',
          level: doc['level'] ?? '',
          exerciseDuration: doc['exerciseDuration'] ?? '',
          createBy: doc['createBy'] ?? '',
        );
        customExerciseModel.add(customModel);
      }
    }
    return customExerciseModel;
  }

  Future<List<ExerciseModel>> get exerciseInfo async {
    final snapshot = await exercisecollection.get();
    return _exerciseTypeFromSnapshot(snapshot);
  }

  List<ExerciseModel> _exerciseTypeFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ExerciseModel(
        id: doc.id,
        number: doc['number'],
        type: doc['type'] ?? '',
        image: doc['image'] ?? '',
      );
    }).toList();
  }

  Future<List<ExerciseDetailModel>> get listExerciseInfo async {
    final querySnapshot =
        await exercisecollection.doc(docID).collection("day$dayindex").get();

    return _dayExericsePlan(querySnapshot);
  }

  List<ExerciseDetailModel> _dayExericsePlan(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ExerciseDetailModel(
        name: doc.get('name') ?? '',
        counter: doc.get('counter').toString(),
        description: doc.get('description') ?? '',
        duration: doc.get('duration').toString(),
        gif: doc.get('gif') ?? '',
        id: doc.id,
      );
    }).toList();
  }

  Future<List<ExerciseDetailModel>> get customPlanDayListFromTrainer async {
    final querySnapshot = await customcollectionfromTrainer
        .doc(docID)
        .collection("day$dayindex")
        .get();
    return _customPlanDayFromTrainer(querySnapshot);
  }

  List<ExerciseDetailModel> _customPlanDayFromTrainer(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ExerciseDetailModel(
        id: doc.id,
        name: doc.get('name') ?? '',
        counter: doc.get('counter').toString(),
        description: doc.get('description') ?? '',
        duration: doc.get('duration').toString(),
        gif: doc.get('gif') ?? '',
      );
    }).toList();
  }

  Future<List<ExerciseDetailModel>> get customPlanDayList async {
    final querySnapshot =
        await customcollection.doc(docID).collection("day$dayindex").get();
    return _customPlanDay(querySnapshot);
  }

  List<ExerciseDetailModel> _customPlanDay(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ExerciseDetailModel(
        name: doc.get('name') ?? '',
        counter: doc.get('counter').toString(),
        description: doc.get('description') ?? '',
        duration: doc.get('duration').toString(),
        gif: doc.get('gif') ?? '',
        id: doc.id,
      );
    }).toList();
  }

  Future<DocumentSnapshot<Object?>> get list async {
    final documentSnapshot = await exercisecollection.doc(docID).get();
    return documentSnapshot;
  }

  Future<List<ExerciseDetailModel>> get allExercises async {
    final snapshot = await allexercisecollection.get();
    return _allExercises(snapshot);
  }

  List<ExerciseDetailModel> _allExercises(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ExerciseDetailModel(
        name: doc.get('name') ?? '',
        counter: doc.get('counter').toString(),
        description: doc.get('description') ?? '',
        duration: doc.get('duration').toString(),
        gif: doc.get('gif') ?? '',
        id: doc.id,
      );
    }).toList();
  }

  Future<List<ExerciseDetailModel>> customExerciseInfo(
      planUid, dayIndex) async {
    final querySnapshot =
        await customcollection.doc(planUid).collection("day$dayIndex").get();
    return _customExericsePlan(querySnapshot);
  }

  List<ExerciseDetailModel> _customExericsePlan(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ExerciseDetailModel(
        name: doc.get('name') ?? '',
        counter: doc.get('counter').toString(),
        description: doc.get('description') ?? '',
        duration: doc.get('duration').toString(),
        gif: doc.get('gif') ?? '',
        id: doc.id,
      );
    }).toList();
  }

  Future<List<ExerciseDetailModel>> userSpecificExerciseInfo(
      uid, dayIndex) async {
    final querySnapshot =
        await usercollection.doc(uid).collection("day$dayIndex").get();
    return _userSpecificPlan(querySnapshot);
  }

  List<ExerciseDetailModel> _userSpecificPlan(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ExerciseDetailModel(
        name: doc.get('name') ?? '',
        counter: doc.get('counter').toString(),
        description: doc.get('description') ?? '',
        duration: doc.get('duration').toString(),
        gif: doc.get('gif') ?? '',
        id: doc.id,
      );
    }).toList();
  }
}

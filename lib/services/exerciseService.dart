import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shapeup/models/exercise_detail_model.dart';
import 'package:shapeup/models/exercise_model.dart';

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

  //get dietInfo stream
  Future<List<ExerciseModel>> get exerciseInfo async {
    final snapshot = await exercisecollection.get();
    return _exerciseTypeFromSnapshot(snapshot);
  }

  List<ExerciseDetailModel> _dayExericsePlan(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ExerciseDetailModel(
        name: doc.get('name') ?? '',
        counter: doc.get('counter').toString(),
        description: doc.get('description') ?? '',
        duration: doc.get('duration').toString(),
        gif: doc.get('gif') ?? '',
      );
    }).toList();
  }

  Future<List<ExerciseDetailModel>> get listExerciseInfo async {
    final querySnapshot =
        await exercisecollection.doc(docID).collection("day$dayindex").get();
    print(querySnapshot);
    return _dayExericsePlan(querySnapshot);
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
      );
    }).toList();
  }

  List<ExerciseDetailModel> _customExericsePlan(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ExerciseDetailModel(
        name: doc.get('name') ?? '',
        counter: doc.get('counter').toString(),
        description: doc.get('description') ?? '',
        duration: doc.get('duration').toString(),
        gif: doc.get('gif') ?? '',
      );
    }).toList();
  }

  Future<List<ExerciseDetailModel>> customExerciseInfo(planUid) async {
    final querySnapshot =
        await customcollection.doc(planUid).collection("day1").get();
    print(querySnapshot);
    return _customExericsePlan(querySnapshot);
  }
}

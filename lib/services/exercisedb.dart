import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shapeup/models/exercise_detail_model.dart';
import 'package:shapeup/models/exercise_model.dart';

class ExerciseDatabase {
  final String? docID;
  final int? dayindex;

  ExerciseDatabase({this.docID, this.dayindex});
  final CollectionReference exercisecollection =
      FirebaseFirestore.instance.collection('exercise');

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
  Stream<List<ExerciseModel>> get exerciseInfo {
    return exercisecollection.snapshots().map(_exerciseTypeFromSnapshot);
  }

  List<ExerciseDetailModel> _dayExericsePlan(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => ExerciseDetailModel(
              name: doc['name'] ?? '',
              counter: doc['counter'].toString(),
              description: doc['description'] ?? '',
              duration: doc['duration'].toString(),
              gif: doc['gif'] ?? '',
            ))
        .toList();
  }

  Stream<List<ExerciseDetailModel>> get listExerciseInfo {
    return exercisecollection
        .doc(docID)
        .collection("day$dayindex")
        .snapshots()
        .map(_dayExericsePlan);
  }

  final CollectionReference doc =
      FirebaseFirestore.instance.collection('exercise');

  Stream<DocumentSnapshot<Object?>> get list {
    return doc.doc(docID).snapshots();
  }
}

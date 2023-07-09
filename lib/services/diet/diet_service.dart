import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shapeup/models/diet/daily_diet_model.dart';
import 'package:shapeup/models/diet/diet_model.dart';

class DietService {
  final String? docID;
  DietService({this.docID});

  final CollectionReference dietCollection =
      FirebaseFirestore.instance.collection('Diet');

  List<DailyDietModel> _dailyDietPlan(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => DailyDietModel(
              id: doc.id,
              amSnack: doc['MidMorning'] ?? '',
              amSnackImage: doc['MidMorningImage'] ?? '',
              breakfast: doc['Breakfast'] ?? '',
              breakfastImage: doc['BreakfastImage'] ?? '',
              dinner: doc['Dinner'] ?? '',
              dinnerImage: doc['DinnerImage'] ?? '',
              lunch: doc['Lunch'] ?? '',
              lunchImage: doc['LunchImage'] ?? '',
              pmSnack: doc['Evening'] ?? '',
              pmSnackImage: doc['EveningImage'] ?? '',
            ))
        .toList();
  }

  Future<List<DailyDietModel>> getDailyDietInfo() async {
    final snapshot = await dietCollection
        .doc(docID)
        .collection('DietLowCarb101')
        .get(); // Assuming `dietCollection` is a Firestore collection reference and `docID` is the ID of the document

    return _dailyDietPlan(snapshot);
  }

  List<DietModel> _dietListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return DietModel(
        id: doc.id,
        title: doc['DietName'] ?? '',
        duration: doc['Duration'] ?? '',
        difficulty: doc['Difficulty'] ?? '',
        imagePath: doc['imageUrl'] ?? '',
        description: doc['Description'] ?? '',
        commitment: doc['Commitment'] ?? '',
        caution: doc['Caution'] ?? '',
        isPremium: doc['isPremium'] ?? false,
      );
    }).toList();
  }

  Future<List<DietModel>> getDietInfo() async {
    final snapshot = await dietCollection
        .get(); // Assuming `dietCollection` is a Firestore collection reference
    return _dietListFromSnapshot(snapshot);
  }
}

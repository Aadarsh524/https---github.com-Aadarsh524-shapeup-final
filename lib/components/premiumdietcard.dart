import 'package:flutter/material.dart';
import 'package:shapeup/models/diet_model.dart';
import 'package:shapeup/screens/premiumdietdetailpage.dart';

class PremiumDietCard extends StatelessWidget {
  final DietModel dietModel;
  const PremiumDietCard({Key? key, required this.dietModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => PremiumDietDetailPage(
                    dietModel: dietModel,
                  ))),
      child: Card(
        //low carb card
        margin: const EdgeInsets.all(10),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        elevation: 10.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.asset(
                  dietModel.imagePath,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 15, left: 15),
              child: Text(
                dietModel.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

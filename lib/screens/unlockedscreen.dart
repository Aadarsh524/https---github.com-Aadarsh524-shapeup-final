import 'package:animated_text_kit/animated_text_kit.dart';
import "package:flutter/material.dart";
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:shapeup/components/premiumdietcard.dart';
import 'package:shapeup/models/diet_model.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class UnlockedScreen extends StatefulWidget {
  const UnlockedScreen({Key? key}) : super(key: key);

  @override
  State<UnlockedScreen> createState() => _UnlockedScreenState();
}

class _UnlockedScreenState extends State<UnlockedScreen> {
  // static const number = '982389232';
  final colorizeColors = [
    Colors.teal,
    Colors.blue,
    Colors.yellow,
    Colors.red,
    Colors.purple,
  ];
  final colorizeTextStyle = const TextStyle(
    fontSize: 35.0,
    fontFamily: 'Horizon',
  );

  final premiumDietList = [
    'Low Carb',
    'High Protein',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 28, 30),
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText('Premium',
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
                speed: const Duration(milliseconds: 300)),
          ],
          isRepeatingAnimation: true,
          repeatForever: true,
          pause: const Duration(milliseconds: 1),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ImageSlideshow(
                      width: double.infinity,
                      initialPage: 0,
                      indicatorColor: Colors.white,
                      indicatorBackgroundColor: Colors.black,
                      autoPlayInterval: 3000,
                      children: [
                        Image.asset(
                          "assets/slider1.png",
                          fit: BoxFit.fitHeight,
                        ),
                        Image.asset(
                          "assets/slider2.png",
                          fit: BoxFit.fitHeight,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            PremiumDietCard(
              dietModel: DietModel(
                  id: '',
                  title: 'Low Carb',
                  imagePath: "assets/diet.png",
                  description:
                      'Ease into low-carb eating in just 4 weeks. This Plan uses our brand new Meal Planner tool to slowly scale back on carbs in a healthy and sustainable way. Build new habits one day at a time while following a meal plan customized for your calorie needs. By Day 28, you\'ll be able to confidently plan and cook low-carb meals and choose foods that fuel your body best.',
                  caution:
                      'Consult your physician before starting any plan. Neither Shape Up nor its affiliates will be liable for any injury sustained as a result of your participation.',
                  duration: '28 days',
                  isPremium: false,
                  // difficulty: 'Beginner,
                  commitment: 'Daily',
                  difficulty: "hard",
                  planCondition: [
                    ' Your calorie goal is between 1200 and 2200 calories.',
                    'Your goal is weight loss or weight maintenance.',
                    'You\'re new to a low-carb eating pattern.',
                    'You\'ve tried low carb before and had trouble feeling full or getting enough fiber.',
                    'You are not a vegetarian (recipes in this Plan include meat and dairy)',
                  ]),
            ),
            PremiumDietCard(
              dietModel: DietModel(
                  id: '',
                  title: 'High Protein',
                  imagePath: "assets/dietpremium.png",
                  description: '',
                  isPremium: true,
                  caution:
                      'Consult your physician before starting any plan. Neither Shape Up nor its affiliates will be liable for any injury sustained as a result of your participation.',
                  duration: '',
                  difficulty: 'Beginner',
                  commitment: 'Daily',
                  planCondition: [
                    ' Your calorie goal is between 1200 and 2200 calories.',
                    'Your goal is weight loss or weight maintenance.',
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

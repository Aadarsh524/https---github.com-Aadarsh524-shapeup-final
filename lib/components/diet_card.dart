import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shapeup/components/glowing_button.dart';
import 'package:shapeup/models/diet_model.dart';
import 'package:shapeup/screens/user/userDashboard/dashboardscreen.dart';
import 'package:shapeup/screens/diet_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

class DietCard extends StatefulWidget {
  final DietModel dietModel;
  const DietCard({Key? key, required this.dietModel}) : super(key: key);

  @override
  State<DietCard> createState() => _DietCardState();
}

class _DietCardState extends State<DietCard> {
  bool isSubscribedUser = false;

  setSubscription() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSubscribedUser = prefs.getBool("premium") ?? false;
    });
  }

  @override
  void initState() {
    setSubscription();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.dietModel.isPremium || isSubscribedUser) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DietDetailPage(
                dietModel: widget.dietModel,
              ),
            ),
          );
        }
      },
      child: Card(
        //low carb card
        margin: const EdgeInsets.all(10),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        elevation: 10.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: widget.dietModel.imagePath,
                  child: CachedNetworkImage(
                    imageUrl: widget.dietModel.imagePath,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ).clipRRect(topLeft: 10, topRight: 10).padding(bottom: 8.0),
                Text(
                  widget.dietModel.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ).padding(bottom: 10, horizontal: 15).backgroundBlur(
                    widget.dietModel.isPremium && !isSubscribedUser ? 10 : 0),
              ],
            ),
            widget.dietModel.isPremium && !isSubscribedUser
                ? GlowingButton(
                    color1: const Color(0xff2193b0),
                    color2: Colors.cyan,
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => const DashBoardScreen(
                                selectedIndex: 4,
                              )));
                    },
                    buttonTitle: 'Unlock Content',
                  )
                : const SizedBox.shrink(),
          ],
        ).clipRRect(all: 10),
      ),
    );
  }
}

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/models/diet_model.dart';
import 'package:shapeup/screens/user/diet/diet_detail_page.dart';
import 'package:styled_widget/styled_widget.dart';

class DietCard extends StatefulWidget {
  final DietModel dietModel;
  const DietCard({Key? key, required this.dietModel}) : super(key: key);

  @override
  State<DietCard> createState() => _DietCardState();
}

class _DietCardState extends State<DietCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DietDetailPage(
                dietModel: widget.dietModel,
              ),
            ),
          );
        },
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: SizedBox(
            width: double.infinity,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Image.network(
                      height: 180,
                      width: double.infinity,
                      colorBlendMode: BlendMode.colorBurn,
                      widget.dietModel.imagePath,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      widget.dietModel.title,
                      style: GoogleFonts.montserrat(
                          color: const Color.fromARGB(255, 226, 226, 226),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

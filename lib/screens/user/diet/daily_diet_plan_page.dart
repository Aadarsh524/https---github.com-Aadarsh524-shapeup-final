import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/models/daily_diet_model.dart';
import 'package:shapeup/services/dietService.dart';
import 'package:styled_widget/styled_widget.dart';

class DailyDietPlanPage extends StatefulWidget {
  final String docId;
  const DailyDietPlanPage({Key? key, required this.docId}) : super(key: key);

  @override
  State<DailyDietPlanPage> createState() => _DailyDietPlanPageState();
}

class _DailyDietPlanPageState extends State<DailyDietPlanPage> {
  PageController controller = PageController();

  int currentIndex = 0;
  int daysLength = 0;

  setLength(int length) {
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        daysLength = length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 28, 30),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        leading: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 114, 97, 89),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: IconButton(
                  color: Colors.black,
                  iconSize: 12,
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
        title: Text("Daily Diet Plan",
            style: GoogleFonts.montserrat(
                letterSpacing: .5,
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600)),
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 5),
          child: Stack(
            children: <Widget>[
              FutureBuilder<List<DailyDietModel>>(
                  future: DietService(docID: widget.docId).getDailyDietInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: PageView.builder(
                          controller: controller,
                          itemCount: snapshot.data!.length,
                          onPageChanged: ((value) {
                            setState(() {
                              currentIndex = value;
                            });
                          }),
                          itemBuilder: (context, index) {
                            setLength(snapshot.data!.length);
                            return SingleChildScrollView(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data![index].id,
                                    style: GoogleFonts.notoSansMono(
                                        color: const Color.fromARGB(
                                            255, 226, 226, 226),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(
                                  height: 20,
                                ),
                                DietDetailWidget(
                                  title: 'Breakfast',
                                  data: snapshot.data![index].breakfast,
                                ),
                                DietDetailWidget(
                                  title: 'AM Snack',
                                  data: snapshot.data![index].amSnack,
                                ),
                                DietDetailWidget(
                                  title: 'Lunch',
                                  data: snapshot.data![index].lunch,
                                ),
                                DietDetailWidget(
                                  title: 'PM Snack',
                                  data: snapshot.data![index].pmSnack,
                                ),
                                DietDetailWidget(
                                  title: 'Dinner',
                                  data: snapshot.data![index].dinner,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.40,
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: ImageSlideshow(
                                          width: double.infinity,
                                          initialPage: 0,
                                          indicatorColor: Colors.white,
                                          indicatorBackgroundColor:
                                              Colors.black,
                                          autoPlayInterval: 3000,
                                          isLoop: true,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: snapshot
                                                  .data![index].breakfastImage,
                                              fit: BoxFit.cover,
                                            ),
                                            CachedNetworkImage(
                                              imageUrl: snapshot
                                                  .data![index].amSnackImage,
                                              fit: BoxFit.cover,
                                            ),
                                            CachedNetworkImage(
                                              imageUrl: snapshot
                                                  .data![index].lunchImage,
                                              fit: BoxFit.cover,
                                            ),
                                            CachedNetworkImage(
                                              imageUrl: snapshot
                                                  .data![index].pmSnackImage,
                                              fit: BoxFit.cover,
                                            ),
                                            CachedNetworkImage(
                                              imageUrl: snapshot
                                                  .data![index].dinnerImage,
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ));
                          },
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          controller.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: Text(
                          'Previous',
                          style: GoogleFonts.notoSansMono(
                              color:
                                  currentIndex == 0 ? Colors.grey : Colors.teal,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: Text(
                          'Next',
                          style: GoogleFonts.notoSansMono(
                              color: (currentIndex + 1) >= daysLength
                                  ? Colors.grey
                                  : Colors.teal,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DietDetailWidget extends StatelessWidget {
  final String title;
  final String data;
  const DietDetailWidget({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: GoogleFonts.montserrat(
            letterSpacing: .5,
            color: Color.fromARGB(255, 125, 128, 122),
            fontSize: 14,
            fontWeight: FontWeight.w500),
        children: [
          TextSpan(
              text: data,
              style: GoogleFonts.montserrat(
                  letterSpacing: .5,
                  color: Color.fromARGB(255, 226, 226, 226),
                  fontSize: 15,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    ).padding(bottom: 15);
  }
}

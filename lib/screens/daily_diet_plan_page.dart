import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:shapeup/models/daily_diet_model.dart';
import 'package:shapeup/services/database_service.dart';
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
      appBar: AppBar(
        title: const Text('Daily Diet Plans'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<List<DailyDietModel>>(
              stream: DatabaseService(docID: widget.docId).dailyDietInfo,
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
                              Text(
                                snapshot.data![index].id,
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
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
                                    MediaQuery.of(context).size.height * 0.45,
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
                          ).padding(top: 20, horizontal: 20),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          Row(
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
                  style: TextStyle(
                      color: currentIndex == 0 ? Colors.grey : Colors.teal),
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
                  style: TextStyle(
                      color: (currentIndex + 1) >= daysLength
                          ? Colors.grey
                          : Colors.teal),
                ),
              ),
            ],
          ),
        ],
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
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: data,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    ).padding(bottom: 15);
  }
}

class DailyDietModel {
  final String id;
  final String amSnack;
  final String amSnackImage;
  final String breakfast;
  final String breakfastImage;
  final String dinner;
  final String dinnerImage;
  final String lunch;
  final String lunchImage;
  final String pmSnack;
  final String pmSnackImage;

  DailyDietModel({
    required this.id,
    required this.amSnack,
    required this.breakfast,
    required this.dinner,
    required this.lunch,
    required this.pmSnack,
    required this.amSnackImage,
    required this.breakfastImage,
    required this.dinnerImage,
    required this.lunchImage,
    required this.pmSnackImage,
  });
}

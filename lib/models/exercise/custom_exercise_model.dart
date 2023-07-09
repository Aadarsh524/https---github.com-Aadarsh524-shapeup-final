class CustomExerciseModel {
  String planName;
  String description;
  String level;
  final String id;
  String exerciseDuration;
  String createBy;

  CustomExerciseModel(
      {required this.planName,
      required this.id,
      required this.description,
      required this.level,
      required this.createBy,
      required this.exerciseDuration});
}

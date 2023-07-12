class CustomExerciseModel {
  String planName;
  String description;
  String level;
  final String id;
  String exerciseDuration;
  String createBy;
  final String planCost;

  CustomExerciseModel(
      {required this.planName,
      required this.id,
      required this.description,
      required this.level,
      required this.createBy,
      required this.planCost,
      required this.exerciseDuration});
}

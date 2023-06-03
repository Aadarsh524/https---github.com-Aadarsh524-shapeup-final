class SubscriptionModel {
  final String title;
  final int price;
  final String time;
  bool isSelected;

  SubscriptionModel({
    required this.title,
    required this.time,
    required this.price,
    required this.isSelected,
  });
}

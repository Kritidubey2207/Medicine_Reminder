class Medicine {
  final String name;
  final String dose;
  final int timeInMinutes;
  final int? notificationId;

  Medicine({
    required this.name,
    required this.dose,
    required this.timeInMinutes,
    this.notificationId,
  });
}

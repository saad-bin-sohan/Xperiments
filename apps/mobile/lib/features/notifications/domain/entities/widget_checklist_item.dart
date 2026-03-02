class WidgetChecklistItem {
  const WidgetChecklistItem({
    required this.experimentId,
    required this.experimentName,
    required this.labName,
    required this.isCheckedInToday,
  });

  final String experimentId;
  final String experimentName;
  final String labName;
  final bool isCheckedInToday;
}

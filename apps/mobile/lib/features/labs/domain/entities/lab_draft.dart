class LabDraft {
  const LabDraft({
    required this.name,
    this.description,
    required this.iconId,
    required this.colorHex,
  });

  final String name;
  final String? description;
  final String iconId;
  final String colorHex;
}

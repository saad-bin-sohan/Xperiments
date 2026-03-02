class GalleryTemplate {
  const GalleryTemplate({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.iconId,
    required this.durationValue,
    required this.durationUnit,
    required this.frequency,
    required this.hypothesis,
    required this.isFeatured,
    this.featuredOrder,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String category;
  final String description;
  final String iconId;
  final int durationValue;
  final String durationUnit;
  final String frequency;
  final String hypothesis;
  final bool isFeatured;
  final int? featuredOrder;
  final DateTime createdAt;
}

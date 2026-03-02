import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/features/gallery/domain/entities/gallery_template.dart';

class GalleryTemplateModel {
  const GalleryTemplateModel({
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

  factory GalleryTemplateModel.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? <String, dynamic>{};

    return GalleryTemplateModel(
      id: doc.id,
      name: data['name'] as String? ?? '',
      category: data['category'] as String? ?? '',
      description: data['description'] as String? ?? '',
      iconId: data['iconId'] as String? ?? '',
      durationValue: (data['durationValue'] as num?)?.toInt() ?? 0,
      durationUnit: data['durationUnit'] as String? ?? 'days',
      frequency: data['frequency'] as String? ?? 'daily',
      hypothesis: data['hypothesis'] as String? ?? '',
      isFeatured: data['isFeatured'] == true,
      featuredOrder: (data['featuredOrder'] as num?)?.toInt(),
      createdAt: _readDate(data['createdAt']) ?? DateTime.now(),
    );
  }

  static DateTime? _readDate(Object? raw) {
    if (raw is Timestamp) {
      return raw.toDate();
    }
    if (raw is DateTime) {
      return raw;
    }
    return null;
  }
}

extension GalleryTemplateModelX on GalleryTemplateModel {
  GalleryTemplate toEntity() {
    return GalleryTemplate(
      id: id,
      name: name,
      category: category,
      description: description,
      iconId: iconId,
      durationValue: durationValue,
      durationUnit: durationUnit,
      frequency: frequency,
      hypothesis: hypothesis,
      isFeatured: isFeatured,
      featuredOrder: featuredOrder,
      createdAt: createdAt,
    );
  }
}

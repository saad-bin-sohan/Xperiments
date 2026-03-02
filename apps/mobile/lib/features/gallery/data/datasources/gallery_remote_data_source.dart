import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/core/constants/firebase_collections.dart';
import 'package:mobile/core/constants/gallery_constants.dart';
import 'package:mobile/features/gallery/data/models/gallery_template_model.dart';
import 'package:mobile/features/gallery/domain/entities/gallery_category_section.dart';

class GalleryRemoteDataSource {
  const GalleryRemoteDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _galleryCollection {
    return _firestore.collection(FirebaseCollections.gallery);
  }

  Stream<List<GalleryTemplateModel>> watchAllTemplates() {
    return _galleryCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => GalleryTemplateModel.fromDoc(doc))
              .toList();
        });
  }

  Stream<List<GalleryTemplateModel>> watchFeaturedTop3() {
    return _galleryCollection
        .where('isFeatured', isEqualTo: true)
        .orderBy('featuredOrder', descending: false)
        .orderBy('createdAt', descending: true)
        .limit(3)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => GalleryTemplateModel.fromDoc(doc))
              .toList();
        });
  }

  Stream<List<GalleryCategorySection>> watchCategorySections() {
    return watchAllTemplates().map((templates) {
      final sections = <GalleryCategorySection>[];
      for (final category in kGalleryCategories) {
        final filtered = templates
            .where((template) => template.category == category)
            .toList();

        if (filtered.isEmpty) {
          continue;
        }

        sections.add(
          GalleryCategorySection(
            category: category,
            templates: filtered.map((template) => template.toEntity()).toList(),
          ),
        );
      }

      return sections;
    });
  }

  Stream<GalleryTemplateModel?> watchTemplateById(String templateId) {
    return _galleryCollection.doc(templateId).snapshots().map((snapshot) {
      if (!snapshot.exists) {
        return null;
      }
      return GalleryTemplateModel.fromDoc(snapshot);
    });
  }
}

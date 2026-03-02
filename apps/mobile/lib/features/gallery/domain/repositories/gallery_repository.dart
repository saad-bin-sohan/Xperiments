import 'package:mobile/features/gallery/domain/entities/gallery_category_section.dart';
import 'package:mobile/features/gallery/domain/entities/gallery_template.dart';

abstract class GalleryRepository {
  Stream<List<GalleryTemplate>> watchAllTemplates();

  Stream<List<GalleryTemplate>> watchFeaturedTop3();

  Stream<List<GalleryCategorySection>> watchCategorySections();

  Stream<GalleryTemplate?> watchTemplateById(String templateId);
}

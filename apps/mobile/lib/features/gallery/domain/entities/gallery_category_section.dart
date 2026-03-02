import 'package:mobile/features/gallery/domain/entities/gallery_template.dart';

class GalleryCategorySection {
  const GalleryCategorySection({
    required this.category,
    required this.templates,
  });

  final String category;
  final List<GalleryTemplate> templates;
}

import 'package:mobile/features/gallery/domain/entities/gallery_template.dart';
import 'package:mobile/features/gallery/domain/repositories/gallery_repository.dart';

class WatchTemplateById {
  const WatchTemplateById(this._repository);

  final GalleryRepository _repository;

  Stream<GalleryTemplate?> call(String templateId) {
    return _repository.watchTemplateById(templateId);
  }
}

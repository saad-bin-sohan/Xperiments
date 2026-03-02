import 'package:mobile/features/gallery/domain/entities/gallery_template.dart';
import 'package:mobile/features/gallery/domain/repositories/gallery_repository.dart';

class WatchAllTemplates {
  const WatchAllTemplates(this._repository);

  final GalleryRepository _repository;

  Stream<List<GalleryTemplate>> call() {
    return _repository.watchAllTemplates();
  }
}

import 'package:mobile/features/gallery/domain/entities/gallery_category_section.dart';
import 'package:mobile/features/gallery/domain/repositories/gallery_repository.dart';

class WatchCategorySections {
  const WatchCategorySections(this._repository);

  final GalleryRepository _repository;

  Stream<List<GalleryCategorySection>> call() {
    return _repository.watchCategorySections();
  }
}

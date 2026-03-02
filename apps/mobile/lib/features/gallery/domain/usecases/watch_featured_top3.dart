import 'package:mobile/features/gallery/domain/entities/gallery_template.dart';
import 'package:mobile/features/gallery/domain/repositories/gallery_repository.dart';

class WatchFeaturedTop3 {
  const WatchFeaturedTop3(this._repository);

  final GalleryRepository _repository;

  Stream<List<GalleryTemplate>> call() {
    return _repository.watchFeaturedTop3();
  }
}

import 'package:mobile/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:mobile/features/gallery/data/models/gallery_template_model.dart';
import 'package:mobile/features/gallery/domain/entities/gallery_category_section.dart';
import 'package:mobile/features/gallery/domain/entities/gallery_template.dart';
import 'package:mobile/features/gallery/domain/repositories/gallery_repository.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  const GalleryRepositoryImpl(this._remoteDataSource);

  final GalleryRemoteDataSource _remoteDataSource;

  @override
  Stream<List<GalleryTemplate>> watchAllTemplates() {
    return _remoteDataSource.watchAllTemplates().map((models) {
      return models
          .map((GalleryTemplateModel model) => model.toEntity())
          .toList();
    });
  }

  @override
  Stream<List<GalleryTemplate>> watchFeaturedTop3() {
    return _remoteDataSource.watchFeaturedTop3().map((models) {
      return models
          .map((GalleryTemplateModel model) => model.toEntity())
          .toList();
    });
  }

  @override
  Stream<List<GalleryCategorySection>> watchCategorySections() {
    return _remoteDataSource.watchCategorySections();
  }

  @override
  Stream<GalleryTemplate?> watchTemplateById(String templateId) {
    return _remoteDataSource.watchTemplateById(templateId).map((model) {
      return model?.toEntity();
    });
  }
}

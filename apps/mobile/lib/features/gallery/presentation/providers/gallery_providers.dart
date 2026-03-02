import 'package:mobile/core/firebase/firebase_providers.dart';
import 'package:mobile/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:mobile/features/gallery/data/repositories/gallery_repository_impl.dart';
import 'package:mobile/features/gallery/domain/entities/gallery_category_section.dart';
import 'package:mobile/features/gallery/domain/entities/gallery_template.dart';
import 'package:mobile/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:mobile/features/gallery/domain/usecases/watch_all_templates.dart';
import 'package:mobile/features/gallery/domain/usecases/watch_category_sections.dart';
import 'package:mobile/features/gallery/domain/usecases/watch_featured_top3.dart';
import 'package:mobile/features/gallery/domain/usecases/watch_template_by_id.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gallery_providers.g.dart';

@Riverpod(keepAlive: true)
GalleryRemoteDataSource galleryRemoteDataSource(Ref ref) {
  return GalleryRemoteDataSource(ref.watch(firestoreProvider));
}

@Riverpod(keepAlive: true)
GalleryRepository galleryRepository(Ref ref) {
  return GalleryRepositoryImpl(ref.watch(galleryRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
WatchAllTemplates watchAllTemplatesUseCase(Ref ref) {
  return WatchAllTemplates(ref.watch(galleryRepositoryProvider));
}

@Riverpod(keepAlive: true)
WatchFeaturedTop3 watchFeaturedTop3UseCase(Ref ref) {
  return WatchFeaturedTop3(ref.watch(galleryRepositoryProvider));
}

@Riverpod(keepAlive: true)
WatchCategorySections watchCategorySectionsUseCase(Ref ref) {
  return WatchCategorySections(ref.watch(galleryRepositoryProvider));
}

@Riverpod(keepAlive: true)
WatchTemplateById watchTemplateByIdUseCase(Ref ref) {
  return WatchTemplateById(ref.watch(galleryRepositoryProvider));
}

@riverpod
Stream<List<GalleryTemplate>> featuredTemplates(Ref ref) {
  return ref.watch(watchFeaturedTop3UseCaseProvider).call();
}

@riverpod
Stream<List<GalleryCategorySection>> galleryCategorySections(Ref ref) {
  return ref.watch(watchCategorySectionsUseCaseProvider).call();
}

@riverpod
Stream<GalleryTemplate?> galleryTemplateById(Ref ref, String templateId) {
  return ref.watch(watchTemplateByIdUseCaseProvider).call(templateId);
}

import 'package:mobile/features/history/domain/entities/history_search_result.dart';
import 'package:mobile/features/history/domain/repositories/history_repository.dart';

class SearchHistoryContent {
  const SearchHistoryContent(this._repository);

  final HistoryRepository _repository;

  Future<List<HistorySearchResult>> call(String userId, String query) {
    return _repository.searchHistoryContent(userId, query);
  }
}

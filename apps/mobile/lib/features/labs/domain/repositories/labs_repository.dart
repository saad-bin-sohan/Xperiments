import 'package:mobile/features/labs/domain/entities/lab.dart';

abstract class LabsRepository {
  Future<void> ensureDefaultLabExists(String userId);

  Stream<List<Lab>> watchUserLabs(String userId);
}

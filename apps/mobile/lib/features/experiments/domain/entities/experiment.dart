import 'package:freezed_annotation/freezed_annotation.dart';

part 'experiment.freezed.dart';

@freezed
abstract class Experiment with _$Experiment {
  const factory Experiment({
    required String id,
    required String userId,
    required String labId,
    required String name,
  }) = _Experiment;
}

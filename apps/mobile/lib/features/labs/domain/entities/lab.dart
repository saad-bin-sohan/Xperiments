import 'package:freezed_annotation/freezed_annotation.dart';

part 'lab.freezed.dart';

@freezed
abstract class Lab with _$Lab {
  const factory Lab({
    required String id,
    required String userId,
    required String name,
    String? description,
    required String iconId,
    required String colorHex,
    required DateTime createdAt,
  }) = _Lab;
}

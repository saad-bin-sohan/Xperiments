import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/features/labs/domain/entities/lab.dart';

part 'lab_model.freezed.dart';

@freezed
abstract class LabModel with _$LabModel {
  const factory LabModel({
    required String id,
    required String userId,
    required String name,
    String? description,
    required String iconId,
    required String colorHex,
    required DateTime createdAt,
  }) = _LabModel;

  factory LabModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    final timestamp = data['createdAt'] as Timestamp?;

    return LabModel(
      id: doc.id,
      userId: data['userId'] as String? ?? '',
      name: data['name'] as String? ?? '',
      description: data['description'] as String?,
      iconId: data['iconId'] as String? ?? '',
      colorHex: data['colorHex'] as String? ?? '#8E8E93',
      createdAt: timestamp?.toDate() ?? DateTime.now(),
    );
  }
}

extension LabModelX on LabModel {
  Lab toEntity() {
    return Lab(
      id: id,
      userId: userId,
      name: name,
      description: description,
      iconId: iconId,
      colorHex: colorHex,
      createdAt: createdAt,
    );
  }
}

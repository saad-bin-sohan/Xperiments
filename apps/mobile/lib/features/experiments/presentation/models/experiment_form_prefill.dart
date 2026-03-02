import 'package:mobile/features/experiments/domain/entities/experiment.dart';
import 'package:mobile/features/gallery/domain/entities/gallery_template.dart';

class ExperimentFormPrefill {
  const ExperimentFormPrefill({
    required this.name,
    this.hypothesis,
    required this.frequency,
    required this.isOpenEnded,
    this.durationValue,
    this.durationUnit,
  });

  final String name;
  final String? hypothesis;
  final ExperimentFrequency frequency;
  final bool isOpenEnded;
  final int? durationValue;
  final ExperimentDurationUnit? durationUnit;

  factory ExperimentFormPrefill.fromTemplate(GalleryTemplate template) {
    return ExperimentFormPrefill(
      name: template.name,
      hypothesis: template.hypothesis,
      frequency: ExperimentFrequency.fromValue(template.frequency),
      isOpenEnded: false,
      durationValue: template.durationValue,
      durationUnit: ExperimentDurationUnit.fromValue(template.durationUnit),
    );
  }
}

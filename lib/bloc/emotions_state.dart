import 'package:PP_787/storages/models/exercise.dart';
import 'package:PP_787/storages/models/trigger.dart';
import 'package:equatable/equatable.dart';

import '../storages/models/anchor.dart';

class EmotionsState extends Equatable {
  const EmotionsState({
    required this.anchors,
    required this.triggers,
    required this.exercises,
  });

  final List<Anchor> anchors;
  final List<Trigger> triggers;
  final List<Exercise> exercises;

  @override
  List<Object?> get props => [anchors, triggers, exercises];

  EmotionsState copyWith({List<Anchor>? anchors, List<Trigger>? triggers, List<Exercise>? exercises}) {
    return EmotionsState(
      anchors: anchors ?? this.anchors,
      triggers: triggers ?? this.triggers,
      exercises: exercises ?? this.exercises,
    );
  }
}

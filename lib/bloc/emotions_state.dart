import 'package:PP_787/storages/models/check_in.dart';
import 'package:PP_787/storages/models/exercise.dart';
import 'package:PP_787/storages/models/trigger.dart';
import 'package:equatable/equatable.dart';

import '../storages/models/anchor.dart';

class EmotionsState extends Equatable {
  const EmotionsState({
    required this.anchors,
    required this.triggers,
    required this.exercises,
    required this.checkIns,
    required this.date,
    required this.allCheckIns
  });

  final List<Anchor> anchors;
  final List<Trigger> triggers;
  final List<Exercise> exercises;
  final List<CheckIn> checkIns;
  final List<CheckIn> allCheckIns;
  final DateTime date;

  @override
  List<Object?> get props =>
      [anchors, triggers, exercises, checkIns, date, allCheckIns];

  EmotionsState copyWith({
    List<Anchor>? anchors,
    List<Trigger>? triggers,
    List<Exercise>? exercises,
    List<CheckIn>? checkIns,
    DateTime? date,
    List<CheckIn>? allCheckIns,
  }) {
    return EmotionsState(
      anchors: anchors ?? this.anchors,
      triggers: triggers ?? this.triggers,
      exercises: exercises ?? this.exercises,
      checkIns: checkIns ?? this.checkIns,
      allCheckIns: allCheckIns ?? this.allCheckIns,
      date: date ?? this.date,
    );
  }
}

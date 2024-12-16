import 'package:PP_787/storages/models/trigger.dart';
import 'package:equatable/equatable.dart';

import '../storages/models/anchor.dart';

class EmotionsState extends Equatable {
  const EmotionsState({
    required this.anchors,
    required this.triggers,
  });

  final List<Anchor> anchors;
  final List<Trigger> triggers;

  @override
  List<Object?> get props => [anchors, triggers];

  EmotionsState copyWith({List<Anchor>? anchors, List<Trigger>? triggers}) {
    return EmotionsState(
      anchors: anchors ?? this.anchors,
      triggers: triggers ?? this.triggers,
    );
  }
}

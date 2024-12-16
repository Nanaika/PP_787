import 'package:equatable/equatable.dart';

import '../storages/models/anchor.dart';

class EmotionsState extends Equatable {
  const EmotionsState({
    required this.anchors,
  });

  final List<Anchor> anchors;

  @override
  List<Object?> get props => [anchors];

  EmotionsState copyWith({List<Anchor>? anchors, }) {
    return EmotionsState(
      anchors: anchors ?? this.anchors,
    );
  }
}

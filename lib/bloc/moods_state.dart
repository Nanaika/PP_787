// import 'package:equatable/equatable.dart';
// import 'package:tt33/storages/models/trigger.dart';
//
// import '../storages/models/mood.dart';
//
// class MoodsState extends Equatable {
//   const MoodsState({
//     this.page = 0,
//     required this.triggers,
//     required this.moods,
//   });
//
//   final int page;
//   final List<Trigger> triggers;
//   final List<Mood> moods;
//
//   @override
//   List<Object?> get props => [page, triggers, moods];
//
//   MoodsState copyWith({int? page, List<Trigger>? triggers, List<Mood>? moods, Mood? todayMood}) {
//     return MoodsState(
//       page: page ?? this.page,
//       triggers: triggers ?? this.triggers,
//       moods: moods ?? this.moods,
//     );
//   }
// }

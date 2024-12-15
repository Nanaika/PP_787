import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../storages/models/mood.dart';

class MoodBloc extends Cubit<Mood> {
  MoodBloc()
      : super(
          Mood(date: DateUtils.dateOnly(DateTime.now()), type: MoodType.values[0], reasons: []),
        );

  void setMood(Mood mood) {
    emit(mood);
    print('SET mood from MOODBLOC---id------  ${state.id}');
  }

  void updateType(int index) {
    emit(state.copyWith(type: MoodType.values[index]));
  }

  void updateComment(String text) {
    emit(state.copyWith(comment: text));
    print('after update comment---id------  ${state.id}');
  }

  void updateReasons(String text) {
    emit(state.copyWith(reasons: [...state.reasons, text]));
  }
  void removeReasons(String text) {
    final copy = state.reasons.toList();
    copy.remove(text);
    emit(state.copyWith(reasons: copy));
  }
}

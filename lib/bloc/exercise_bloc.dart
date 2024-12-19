import 'package:PP_787/storages/models/exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseBloc extends Cubit<Exercise> {
  ExerciseBloc()
      : super(
          Exercise(date: DateUtils.dateOnly(DateTime.now()), words: ['', '', ''], answers: ['', '', '', '']),
        );

  void updateWord(String text, int index) {
    text.trim();
    final copy = state.words.toList();
    copy[index] = text;
    emit(state.copyWith(words: copy));
  }

  void updateAnswer(String text, int index) {
    text.trim();
    final copy = state.answers.toList();
    copy[index] = text;
    emit(state.copyWith(answers: copy));
  }

  bool canWordsNext() {
    for (int i = 0; i < state.words.length; i++) {
      if (state.words[i] == '') {
        return false;
      }
    }
    return true;
  }

  bool canAnswerNext(int index) {
    if (state.answers[index] == '') {
      return false;
    }

    return true;
  }
}

import 'package:PP_787/bloc/emotions_state.dart';
import 'package:PP_787/storages/models/anchor.dart';
import 'package:PP_787/storages/models/check_in.dart';
import 'package:PP_787/storages/models/exercise.dart';
import 'package:PP_787/storages/models/trigger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../storages/isar.dart';

class EmotionsBloc extends Cubit<EmotionsState> {
  EmotionsBloc()
      : super(
          EmotionsState(
            anchors: [],
            triggers: [],
            exercises: [],
            checkIns: [],
            allCheckIns: [],
            date: DateUtils.dateOnly(
              DateTime.now(),
            ),
          ),
        ) {
    getAnchors();
    getTriggers();
    getExercises(state.date);
    getCheckIns(state.date);
    getAllCheckIns();
  }

  Future<void> updateDate(DateTime newDate) async {
    emit(state.copyWith(date: newDate));
    getCheckIns(newDate);
    getExercises(newDate);
    getAllCheckIns();
  }

  Future<void> getCheckIns(DateTime date) async {
    final checkIns = await AppIsarDatabase.getCheckIns(date);
    emit(
      state.copyWith(
        checkIns: checkIns,
      ),
    );
  }

  Future<void> getAllCheckIns() async {
    final checkIns = await AppIsarDatabase.getAllCheckIns();
    emit(
      state.copyWith(
        allCheckIns: checkIns,
      ),
    );
  }

  Future<void> addCheckIn(CheckIn checkIn) async {
    await AppIsarDatabase.addCheckIn(checkIn);
    await getCheckIns(state.date);
    getAllCheckIns();
  }

  Future<void> getAnchors() async {
    final anchors = await AppIsarDatabase.getAnchors();
    emit(
      state.copyWith(
        anchors: anchors,
      ),
    );
  }

  Future<void> addAnchor(Anchor anchor) async {
    await AppIsarDatabase.addAnchor(anchor);
    await getAnchors();
  }

  Future updateEmotions(int id, List<Emotion> emotions) async {
    await AppIsarDatabase.updateEmotions(emotions, id);
    getTriggers();
  }

  Future<void> getTriggers() async {
    final triggers = await AppIsarDatabase.getTriggers();
    emit(
      state.copyWith(
        triggers: triggers,
      ),
    );
  }

  Future<void> addTrigger(Trigger trigger) async {
    await AppIsarDatabase.addTrigger(trigger);
    await getTriggers();
  }

  Future<void> deleteTrigger(int id) async {
    await AppIsarDatabase.deleteTrigger(id);
    await getTriggers();
  }

  Future<void> getExercises(DateTime date) async {
    final exercises = await AppIsarDatabase.getExercises(date);
    emit(
      state.copyWith(
        exercises: exercises,
      ),
    );
  }

  Future<void> addExercise(Exercise exercise) async {
    await AppIsarDatabase.addExercise(exercise);
    await getExercises(state.date);
  }
}

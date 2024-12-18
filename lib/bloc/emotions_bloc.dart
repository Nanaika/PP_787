import 'package:PP_787/bloc/emotions_state.dart';
import 'package:PP_787/storages/models/anchor.dart';
import 'package:PP_787/storages/models/check_in.dart';
import 'package:PP_787/storages/models/exercise.dart';
import 'package:PP_787/storages/models/trigger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../storages/isar.dart';

class EmotionsBloc extends Cubit<EmotionsState> {
  EmotionsBloc() : super(EmotionsState(anchors: [], triggers: [], exercises: [], checkIns: [])) {
    getAnchors();
    getTriggers();
    getExercises();
    getCheckIns();
  }

  Future<void> getCheckIns() async {
    final checkIns = await AppIsarDatabase.getCheckIns(
    );
    emit(
      state.copyWith(
        checkIns: checkIns,
      ),
    );
  }

  Future<void> addCheckIn(CheckIn checkIn) async {
    await AppIsarDatabase.addCheckIn(checkIn);
    await getCheckIns();
  }


  Future<void> getAnchors() async {
    final anchors = await AppIsarDatabase.getAnchors(
    );
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
    final triggers = await AppIsarDatabase.getTriggers(
    );
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

  Future<void> getExercises() async {
    final exercises = await AppIsarDatabase.getExercises(
    );
    emit(
      state.copyWith(
        exercises: exercises,
      ),
    );

    for(int i = 0; i < exercises.length; i++) {
    print('ESEC --- ${exercises[i].date}');
    print('ESEC --- ${exercises[i].words}');
    print('ESEC --- ${exercises[i].answers}');
    }
  }

  Future<void> addExercise(Exercise exercise) async {
    await AppIsarDatabase.addExercise(exercise);
    await getExercises();
  }

  // Future<void> addMood(Mood mood) async {
  //   print('ADD MOOD from BLOC ----------------  ${mood.id}');
  //   await AppIsarDatabase.addMood(mood);
  //   await getMoods();
  //
  // }
  //
  // Future<void> updateMood(Mood mood, int id) async {
  //   await AppIsarDatabase.updateMood(mood, id);
  //   await getMoods();
  //
  // }
  //
  // Future<void> getMoods() async {
  //   final moods = await AppIsarDatabase.getMoods(
  //   );
  //   emit(
  //     state.copyWith(
  //       moods: moods,
  //     ),
  //   );
  // }


  //
  // Future<void> deleteTask(int id) async {
  //   await AppIsarDatabase.deleteTask(id);
  //   await getTasks();
  // }
  //
  // Future<void> updateTask(int id, TaskState task) async {
  //   await AppIsarDatabase.updateTask(id, task.toIsarModel());
  //   await getTasks();
  // }
  //


  //
  // Future<void> updateTaskType(int index) async {
  //   emit(state.copyWith(taskType: index));
  //   await getTasks();
  // }
  //
  // Future<void> updateTaskDaily(bool value) async {
  //   emit(state.copyWith(taskDaily: value));
  //   await getTasks();
  // }
  //
  // Future<void> getGoals() async {
  //   final goals = await AppIsarDatabase.getGoals();
  //   emit(
  //     state.copyWith(
  //       goals: goals.reversed.map((e) => GoalState.fromIsarModel(e)).toList(),
  //     ),
  //   );
  // }
  //
  // Future<void> addGoal(GoalState goal) async {
  //   await AppIsarDatabase.addGoal(goal.toIsarModel());
  //   await getGoals();
  // }
  //
  // Future<void> deleteGoal(int id) async {
  //   await AppIsarDatabase.deleteGoal(id);
  //   await getGoals();
  // }
  //
  // Future<void> updateGoal(int id, GoalState goal) async {
  //   await AppIsarDatabase.updateGoal(id, goal.toIsarModel());
  //   await getGoals();
  // }
  //
  // Future<void> getHabits() async {
  //   final habits = await AppIsarDatabase.getHabits();
  //   emit(
  //     state.copyWith(
  //       habits:
  //           habits.reversed.map((e) => HabitState.fromIsarModel(e)).toList(),
  //     ),
  //   );
  // }
  //
  // Future<void> addHabit(HabitState habit) async {
  //   await AppIsarDatabase.addHabit(habit.toIsarModel());
  //   await getHabits();
  // }
  //
  // Future<void> deleteHabit(int id) async {
  //   await AppIsarDatabase.deleteHabit(id);
  //   await getHabits();
  // }
  //
  // Future<void> updateHabit(int id, HabitState habit) async {
  //   await AppIsarDatabase.updateHabit(id, habit.toIsarModel());
  //   await getHabits();
  // }
}

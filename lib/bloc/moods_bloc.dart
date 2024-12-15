// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tt33/bloc/moods_state.dart';
//
// import '../storages/isar.dart';
// import '../storages/models/mood.dart';
// import '../storages/models/trigger.dart';
//
// class MoodsBloc extends Cubit<MoodsState> {
//   MoodsBloc() : super(MoodsState(triggers: [], moods: [])) {
//     getTriggers();
//     getMoods();
//   }
//
//   Future<void> getTriggers() async {
//     final triggers = await AppIsarDatabase.getTriggers(
//     );
//     emit(
//       state.copyWith(
//         triggers: triggers,
//       ),
//     );
//   }
//
//   Future<void> addTrigger(Trigger trigger) async {
//     await AppIsarDatabase.addTrigger(trigger);
//     await getTriggers();
//   }
//
//   Future<void> addMood(Mood mood) async {
//     print('ADD MOOD from BLOC ----------------  ${mood.id}');
//     await AppIsarDatabase.addMood(mood);
//     await getMoods();
//
//   }
//
//   Future<void> updateMood(Mood mood, int id) async {
//     await AppIsarDatabase.updateMood(mood, id);
//     await getMoods();
//
//   }
//
//   Future<void> getMoods() async {
//     final moods = await AppIsarDatabase.getMoods(
//     );
//     emit(
//       state.copyWith(
//         moods: moods,
//       ),
//     );
//   }
//
//
//   //
//   // Future<void> deleteTask(int id) async {
//   //   await AppIsarDatabase.deleteTask(id);
//   //   await getTasks();
//   // }
//   //
//   // Future<void> updateTask(int id, TaskState task) async {
//   //   await AppIsarDatabase.updateTask(id, task.toIsarModel());
//   //   await getTasks();
//   // }
//   //
//   void updatePage(int index) {
//     emit(state.copyWith(page: index));
//   }
//
//   //
//   // Future<void> updateTaskType(int index) async {
//   //   emit(state.copyWith(taskType: index));
//   //   await getTasks();
//   // }
//   //
//   // Future<void> updateTaskDaily(bool value) async {
//   //   emit(state.copyWith(taskDaily: value));
//   //   await getTasks();
//   // }
//   //
//   // Future<void> getGoals() async {
//   //   final goals = await AppIsarDatabase.getGoals();
//   //   emit(
//   //     state.copyWith(
//   //       goals: goals.reversed.map((e) => GoalState.fromIsarModel(e)).toList(),
//   //     ),
//   //   );
//   // }
//   //
//   // Future<void> addGoal(GoalState goal) async {
//   //   await AppIsarDatabase.addGoal(goal.toIsarModel());
//   //   await getGoals();
//   // }
//   //
//   // Future<void> deleteGoal(int id) async {
//   //   await AppIsarDatabase.deleteGoal(id);
//   //   await getGoals();
//   // }
//   //
//   // Future<void> updateGoal(int id, GoalState goal) async {
//   //   await AppIsarDatabase.updateGoal(id, goal.toIsarModel());
//   //   await getGoals();
//   // }
//   //
//   // Future<void> getHabits() async {
//   //   final habits = await AppIsarDatabase.getHabits();
//   //   emit(
//   //     state.copyWith(
//   //       habits:
//   //           habits.reversed.map((e) => HabitState.fromIsarModel(e)).toList(),
//   //     ),
//   //   );
//   // }
//   //
//   // Future<void> addHabit(HabitState habit) async {
//   //   await AppIsarDatabase.addHabit(habit.toIsarModel());
//   //   await getHabits();
//   // }
//   //
//   // Future<void> deleteHabit(int id) async {
//   //   await AppIsarDatabase.deleteHabit(id);
//   //   await getHabits();
//   // }
//   //
//   // Future<void> updateHabit(int id, HabitState habit) async {
//   //   await AppIsarDatabase.updateHabit(id, habit.toIsarModel());
//   //   await getHabits();
//   // }
// }

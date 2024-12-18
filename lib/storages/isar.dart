import 'package:PP_787/storages/models/anchor.dart';
import 'package:PP_787/storages/models/check_in.dart';
import 'package:PP_787/storages/models/exercise.dart';
import 'package:PP_787/storages/models/trigger.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';


abstract class AppIsarDatabase {
  static late final Isar _instance;

  static Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();
    return _instance = await Isar.open(
      [AnchorSchema, TriggerSchema, ExerciseSchema, CheckInSchema],
      directory: dir.path,
    );
  }

  static Future<void> addCheckIn(CheckIn checkIn) async {
    await _instance.writeTxn(() async => await _instance.checkIns.put(checkIn));
  }

  static Future<List<CheckIn>> getCheckIns(DateTime date) async {
    return await _instance.writeTxn(
          () async => await _instance.checkIns.filter().dateEqualTo(date).sortByDateDesc().findAll(),
    );
  }

  static Future<List<CheckIn>> getAllCheckIns() async {
    return await _instance.writeTxn(
          () async => await _instance.checkIns.where().sortByDateDesc().findAll(),
    );
  }

  static Future<void> addAnchor(Anchor anchor) async {
    await _instance.writeTxn(() async => await _instance.anchors.put(anchor));
  }

  static Future<List<Anchor>> getAnchors() async {
    return await _instance.writeTxn(
      () async => await _instance.anchors.where().findAll(),
    );
  }

  static Future<void> addTrigger(Trigger trigger) async {
    await _instance.writeTxn(() async => await _instance.triggers.put(trigger));
  }

  static Future<List<Trigger>> getTriggers() async {
    return await _instance.writeTxn(
          () async => await _instance.triggers.where().findAll(),
    );
  }


  static Future<void> updateEmotions(List<Emotion> emotions, int id) async {
    final old = await _instance.triggers.get(id);
    if (old != null) {
      old.emotions = emotions;
      await _instance.writeTxn(() async => await _instance.triggers.put(old));
    }
  }

  static Future<void> deleteTrigger(int id) async {
    await _instance.writeTxn(() async => await _instance.triggers.delete(id));
  }

  static Future<void> addExercise(Exercise exercise) async {
    await _instance.writeTxn(() async => await _instance.exercises.put(exercise));
  }

  static Future<List<Exercise>> getExercises(DateTime date) async {
    return await _instance.writeTxn(
          () async => await _instance.exercises.filter().dateEqualTo(date).findAll(),
    );
  }

  //
  // static Future<List<Mood>> getMoods() async {
  //   return await _instance.writeTxn(
  //     () async => await _instance.moods.where().sortByDateDesc().findAll(),
  //   );
  // }

//
//   static Future<void> addTask(Task task) async {
//     await _instance.writeTxn(() async => await _instance.tasks.put(task));
//   }
//

//
//   static Future<void> updateTask(int id, Task newTask) async {
//     await _instance.writeTxn(() async {
//       final task = await _instance.tasks.get(id);
//       if (task != null) {
//         task
//           ..type = newTask.type
//           ..name = newTask.name
//           ..date = newTask.date
//           ..done = newTask.done;
//         return await _instance.tasks.put(task);
//       }
//     });
//   }
//
//   static Future<List<Goal>> getGoals() async {
//     return await _instance
//         .writeTxn(() async => await _instance.goals.where().findAll());
//   }
//
//   static Future<void> addGoal(Goal goal) async {
//     await _instance.writeTxn(() async => await _instance.goals.put(goal));
//   }
//
//   static Future<void> deleteGoal(int id) async {
//     await _instance.writeTxn(() async => await _instance.goals.delete(id));
//   }
//
//   static Future<void> updateGoal(int id, Goal newGoal) async {
//     await _instance.writeTxn(() async {
//       final goal = await _instance.goals.get(id);
//       if (goal != null) {
//         goal
//           ..type = newGoal.type
//           ..name = newGoal.name
//           ..dates = newGoal.dates
//           ..value = newGoal.value;
//         return await _instance.goals.put(goal);
//       }
//     });
//   }
//
//   static Future<List<Habit>> getHabits() async {
//     return await _instance
//         .writeTxn(() async => await _instance.habits.where().findAll());
//   }
//
//   static Future<void> addHabit(Habit habit) async {
//     await _instance.writeTxn(() async => await _instance.habits.put(habit));
//   }
//
//   static Future<void> deleteHabit(int id) async {
//     await _instance.writeTxn(() async => await _instance.habits.delete(id));
//   }
//
//   static Future<void> updateHabit(int id, Habit newHabit) async {
//     await _instance.writeTxn(() async {
//       final habit = await _instance.habits.get(id);
//       if (habit != null) {
//         habit
//           ..daily = newHabit.daily
//           ..name = newHabit.name
//           ..number = newHabit.number
//           ..dates = newHabit.dates
//           ..category = newHabit.category;
//         return await _instance.habits.put(habit);
//       }
//     });
//   }
}

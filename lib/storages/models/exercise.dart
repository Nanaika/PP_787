import 'package:isar/isar.dart';

part 'exercise.g.dart';

@collection
class Exercise {
  Id id = Isar.autoIncrement;
  DateTime date;
  List<String> words;
  List<String> answers;

  Exercise({required this.date, required this.words, required this.answers});

  Exercise copyWith({DateTime? date, List<String>? words, List<String>? answers}) {
    return Exercise(
      date: date ?? this.date,
      words: words ?? this.words,
      answers: answers ?? this.answers,
    );
  }
}

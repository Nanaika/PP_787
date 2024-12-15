import 'package:isar/isar.dart';

part 'mood.g.dart';

@collection
class Mood {
  Id id = Isar.autoIncrement;
  DateTime date;
  @enumerated
  MoodType type;
  List<String> reasons;
  String comment;

  Mood({required this.date, required this.type, required this.reasons,this.comment = ''});

  @override
  String toString() {
    return 'id = $id\ndate = ${date.year}/${date.month}/${date.day}\ntype = $type';
  }

  Mood copyWith({
    DateTime? date,
    MoodType? type,
    List<String>? reasons,
    String? comment,
  }) {
    return Mood(
      date: date ?? this.date,
      type: type ?? this.type,
      reasons: reasons ?? List.from(this.reasons),
      comment: comment ?? this.comment,
    );
  }
}
enum MoodType {
  happy, sad, angry, anxiety
}
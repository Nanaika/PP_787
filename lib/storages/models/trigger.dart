import 'package:isar/isar.dart';

part 'trigger.g.dart';

@collection
class Trigger {
  Id id = Isar.autoIncrement;
  String name;
  List<Emotion> emotions;

  Trigger({required this.name, required this.emotions});

  Trigger copyWith({String? name, List<Emotion>? emotions}) {
    return Trigger(
      name: name ?? this.name,
      emotions: emotions ?? this.emotions,
    );
  }
}
@embedded
class Emotion {
  @enumerated
  Emotions type;
  int count;

  Emotion({this.type = Emotions.none, this.count = 0});
}
enum Emotions {
  Affection,
  Hope,
  Joy,
  Boredom,
  Balance,
  Sadness,
  Confusion,
  Anxiety,
  Meloncholia,
  Irritation,
  Anger,
  Tension,
  none,
}

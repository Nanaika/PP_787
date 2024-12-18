import 'package:isar/isar.dart';

part 'check_in.g.dart';

@collection
class CheckIn {
  Id id = Isar.autoIncrement;
  DateTime date;
  bool isCustom;
  int index;
  String name;
  @enumerated
  FeelingType feeling;
  int feelingPower;
  String triggerBy;

  CheckIn({
    required this.date,
    required this.isCustom,
    required this.index,
    required this.name,
    required this.feeling,
    required this.feelingPower,
    required this.triggerBy,
  });

  CheckIn copyWith({
    DateTime? date,
    bool? isCustom,
    int? index,
    String? name,
    FeelingType? feeling,
    int? feelingPower,
    String? triggerBy,
  }) {
    return CheckIn(
      date: date ?? this.date,
      isCustom: isCustom ?? this.isCustom,
      index: index ?? this.index,
      name: name ?? this.name,
      feeling: feeling ?? this.feeling,
      feelingPower: feelingPower ?? this.feelingPower,
      triggerBy: triggerBy ?? this.triggerBy,
    );
  }

}

enum FeelingType { Positive, Neutral, Negative, NotSelected }

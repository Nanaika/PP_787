import 'package:isar/isar.dart';

part 'anchor.g.dart';

@collection
class Anchor {
  Id id = Isar.autoIncrement;
  String name;

  Anchor({required this.name});

  Anchor copyWith({String? name}) {
    return Anchor(
      name: name ?? this.name,
    );
  }
}

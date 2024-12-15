import 'package:isar/isar.dart';

part 'trigger.g.dart';

@collection
class Trigger {
  Id id = Isar.autoIncrement;
  final String name;
  final List<String> triggers;
  final String comment;

  Trigger({required this.name, required this.triggers, this.comment = ''});
}
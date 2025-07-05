import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.createdAtTime,
    required this.createdAtDate,
    required this.isCompleted,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String subTitle;
  @HiveField(3)
  DateTime createdAtTime;
  @HiveField(4)
  DateTime createdAtDate;
  @HiveField(5)
  bool isCompleted;

  factory Task.create({
    required String? title,
    required String? subTitle,
    DateTime? createdAtDate,
    DateTime? createdAtTime,
    required bool? isCompleted,
  }) => Task(
    id: const Uuid().v1(),
    title: title ?? '',
    subTitle: subTitle ?? '',
    createdAtDate: createdAtDate ?? DateTime.now(),
    createdAtTime: createdAtTime ?? DateTime.now(),
    isCompleted: false,
  );
}

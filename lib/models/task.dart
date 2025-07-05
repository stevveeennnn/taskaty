import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
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

  Task({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.createdAtTime,
    required this.createdAtDate,
    required this.isCompleted,
  });

  factory Task.create({
    required String title,
    required String subTitle,
    required DateTime createdAtDate,
    required DateTime createdAtTime,
    bool isCompleted = false,
  }) {
    return Task(
      id: Uuid().v1(),
      title: title,
      subTitle: subTitle,
      createdAtTime: createdAtTime,
      createdAtDate: createdAtDate,
      isCompleted: isCompleted,
    );
  }

  Task copyWith({
    String? id,
    String? title,
    String? subTitle,
    DateTime? createdAtTime,
    DateTime? createdAtDate,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      createdAtTime: createdAtTime ?? this.createdAtTime,
      createdAtDate: createdAtDate ?? this.createdAtDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
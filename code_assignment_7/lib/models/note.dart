import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String body;

  @HiveField(3)
  final bool isFinished;

  @HiveField(4)
  final DateTime? lastEdited;

  Note({
    required this.id,
    required this.title,
    required this.body,
    this.isFinished = false,
    this.lastEdited,
  });

  Note copyWith({
    String? id,
    String? title,
    String? body,
    bool? isFinished,
    DateTime? lastEdited,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      isFinished: isFinished ?? this.isFinished,
      lastEdited: lastEdited ?? this.lastEdited,
    );
  }
}

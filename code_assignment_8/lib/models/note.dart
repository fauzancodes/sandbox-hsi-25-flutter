import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final DateTime? updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.updatedAt,
  });

  Note copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json["id"] as String,
      title: json["title"] as String,
      content: json["content"] as String,
      updatedAt: json["updated_at"] != null
        ? DateTime.parse(json["updated_at"])
        : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "updated_at": updatedAt?.toIso8601String(),
    };
  }
}

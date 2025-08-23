import 'package:equatable/equatable.dart';
import '../../models/note.dart';

enum NoteStatus { initial, loading, success, failure }

class NoteState extends Equatable {
  final NoteStatus status;
  final List<Note> notes;
  final String? message;

  const NoteState({
    this.status = NoteStatus.initial,
    this.notes = const [],
    this.message,
  });

  NoteState copyWith({
    NoteStatus? status,
    List<Note>? notes,
    String? message,
  }) {
    return NoteState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, notes, message];
}

import 'package:equatable/equatable.dart';
import '../../models/note.dart';

abstract class NoteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final Note note;
  AddNote(this.note);

  @override
  List<Object?> get props => [note];
}

class DeleteNote extends NoteEvent {
  final String id;
  DeleteNote(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateNote extends NoteEvent {
  final String id;
  final String title;
  final String body;
  final bool? isFinished;

  UpdateNote(this.id, this.title, this.body, {this.isFinished});

  @override
  List<Object?> get props => [id, title, body, isFinished ?? ''];
}

class ToggleFinishNote extends NoteEvent {
  final String id;
  ToggleFinishNote(this.id);

  @override
  List<Object?> get props => [id];
}

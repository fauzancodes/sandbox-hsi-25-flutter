import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../models/note.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(const NoteState()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNote>(_onAddNote);
    on<DeleteNote>(_onDeleteNote);
    on<UpdateNote>(_onUpdateNote);
    on<ToggleFinishNote>(_onToggleFinishNote);
  }

  Future<void> _onLoadNotes(
    LoadNotes event,
    Emitter<NoteState> emit,
  ) async {
    emit(state.copyWith(status: NoteStatus.loading));

    try {
      var box = Hive.box<Note>('notes');
      final notes = box.values.toList();
      emit(state.copyWith(status: NoteStatus.success, notes: notes));
    } catch (e) {
      emit(state.copyWith(
        status: NoteStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onAddNote(
    AddNote event,
    Emitter<NoteState> emit,
  ) async {
    try {
      var box = Hive.box<Note>('notes');
      await box.put(event.note.id, event.note);
      add(LoadNotes());
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.failure, message: e.toString()));
    }
  }

  Future<void> _onDeleteNote(
    DeleteNote event,
    Emitter<NoteState> emit,
  ) async {
    try {
      var box = Hive.box<Note>('notes');
      await box.delete(event.id);
      add(LoadNotes());
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.failure, message: e.toString()));
    }
  }

  Future<void> _onUpdateNote(
    UpdateNote event,
    Emitter<NoteState> emit,
  ) async {
    try {
      var box = Hive.box<Note>('notes');
      final oldNote = box.get(event.id);
      if (oldNote == null) return;

      final updatedNote = oldNote.copyWith(
        title: event.title,
        body: event.body,
        isFinished: event.isFinished ?? oldNote.isFinished,
        lastEdited: DateTime.now(),
      );

      await box.put(event.id, updatedNote);
      add(LoadNotes());
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.failure, message: e.toString()));
    }
  }

  Future<void> _onToggleFinishNote(
    ToggleFinishNote event,
    Emitter<NoteState> emit,
  ) async {
    try {
      var box = Hive.box<Note>('notes');
      final oldNote = box.get(event.id);
      if (oldNote == null) return;

      final updatedNote = oldNote.copyWith(
        isFinished: !oldNote.isFinished,
        lastEdited: DateTime.now(),
      );

      await box.put(event.id, updatedNote);
      add(LoadNotes());
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.failure, message: e.toString()));
    }
  }
}

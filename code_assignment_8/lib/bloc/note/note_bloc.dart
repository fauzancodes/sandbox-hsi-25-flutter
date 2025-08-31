import 'package:code_assignment_8/service/note_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/note.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteAPIService apiService;
  NoteBloc({required this.apiService}) : super(const NoteState()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNote>(_onAddNote);
    on<DeleteNote>(_onDeleteNote);
    on<UpdateNote>(_onUpdateNote);
  }

  Future<void> _onLoadNotes(
    LoadNotes event,
    Emitter<NoteState> emit,
  ) async {
    emit(state.copyWith(status: NoteStatus.loading));

    try {
      final notes = await apiService.fetchNotes();
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
      await apiService.addNote(event.note);
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
      await apiService.deleteNote(event.id);
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
      final updatedNote = Note(
        id: event.id,
        title: event.title,
        content: event.content,
      );

      await apiService.updateNote(updatedNote);
      add(LoadNotes());
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.failure, message: e.toString()));
    }
  }
}

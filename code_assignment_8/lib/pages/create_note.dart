import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../bloc/note/note_bloc.dart';
import '../bloc/note/note_event.dart';
import '../models/note.dart';
import '../views/create_note.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void _saveNoteAndBack() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty && content.isEmpty) {
      Navigator.pop(context);
      return;
    }

    final uuid = const Uuid();
    final note = Note(
      id: uuid.v4(),
      title: title,
      content: content,
    );

    context.read<NoteBloc>().add(AddNote(note));

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CreateNoteForm(
        titleController: _titleController,
        contentController: _contentController,
        saveNoteAndBack: _saveNoteAndBack,
      ),
    );
  }
}

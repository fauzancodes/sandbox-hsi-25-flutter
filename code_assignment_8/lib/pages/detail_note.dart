import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:code_assignment_8/bloc/note/note_bloc.dart';
import 'package:code_assignment_8/bloc/note/note_event.dart';
import 'package:code_assignment_8/bloc/note/note_state.dart';
import 'package:code_assignment_8/models/note.dart';
import 'package:code_assignment_8/views/detail_note.dart';

class DetailNotePage extends StatelessWidget {
  final String noteKey;

  const DetailNotePage({super.key, required this.noteKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        final note = state.notes.firstWhere(
          (n) => n.id == noteKey,
          orElse: () => Note(
            id: noteKey,
            title: "",
            content: "",
          ),
        );

        final titleController = TextEditingController(text: note.title);
        final contentController = TextEditingController(text: note.content);

        String getLastEditedText() {
          final edited = note.updatedAt?.toLocal() ?? DateTime.now();
          final now = DateTime.now();
          final isSameDay = edited.year == now.year &&
            edited.month == now.month &&
            edited.day == now.day;

          if (isSameDay) {
            return "Last edited at ${edited.hour.toString().padLeft(2, '0')}:${edited.minute.toString().padLeft(2, '0')}";
          } else {
            return "Last edited on ${edited.day.toString().padLeft(2, '0')}/${edited.month.toString().padLeft(2, '0')}/${edited.year}";
          }
        }

        return DetailNoteForm(
          titleController: titleController,
          contentController: contentController,
          getLastEditedText: getLastEditedText,
          updateNoteAndBack: () {
            context.read<NoteBloc>().add(
                  UpdateNote(
                    noteKey,
                    titleController.text.trim(),
                    contentController.text.trim(),
                  ),
                );
            Navigator.pop(context);
          },
          showActionModal: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (ctx) {
                return SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.check_circle_outline),
                        title: Text("Mark as Finished"),
                        onTap: () {
                          context;
                          Navigator.pop(ctx);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete_outline,
                            color: Colors.red),
                        title: const Text(
                          "Delete Note",
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () {
                          context.read<NoteBloc>().add(DeleteNote(noteKey));
                          Navigator.pop(ctx);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

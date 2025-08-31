import 'package:code_assignment_8/pages/create_note.dart';
import 'package:code_assignment_8/pages/detail_note.dart';
import 'package:code_assignment_8/service/note_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/note/note_bloc.dart';
import '../bloc/note/note_event.dart';
import '../bloc/note/note_state.dart';

class NoteListPage extends StatelessWidget {
  const NoteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteBloc(apiService: NoteAPIService())..add(LoadNotes()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocBuilder<NoteBloc, NoteState>(
              builder: (context, state) {
                if (state.status == NoteStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.status == NoteStatus.failure) {
                  return Center(
                    child: Text(
                      state.message ?? "Failed to load notes",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (state.notes.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/empty_note.png',
                          width: 245,
                          height: 219,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Start Your Journey',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF180E25),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 90),
                          child: Text(
                            'Every big step start with small step. Notes your first idea and start your journey!',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF827D89),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Image.asset(
                          'assets/images/empty_note_arrow.png',
                          width: 169,
                          height: 123,
                        ),
                      ],
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: state.notes.length,
                    itemBuilder: (context, index) {
                      final note = state.notes[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<NoteBloc>(),
                                child: DetailNotePage(noteKey: note.id),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFEFEEF0)),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      note.title,
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF180E25),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                note.content.length > 150
                                    ? '${note.content.substring(0, 150)}...'
                                    : note.content,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF180E25),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            floatingActionButton: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFAF8FC),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: 64,
                  height: 64,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<NoteBloc>(),
                            child: const CreateNotePage(),
                          ),
                        ),
                      );
                    },
                    backgroundColor: const Color(0xFF394675),
                    shape: const CircleBorder(),
                    child: const Icon(Icons.add, size: 32, color: Colors.white),
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }
}

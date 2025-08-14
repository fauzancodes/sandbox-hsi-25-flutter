import 'package:code_assignment_6/pages/create_note.dart';
import 'package:code_assignment_6/pages/detail_note.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/note.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteListPage extends StatelessWidget {
  const NoteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var notesBox = Hive.box<Note>('notes');

    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: notesBox.listenable(),
        builder: (context, Box<Note> box, _) {
          if (box.isEmpty) {
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
              itemCount: box.length,
              itemBuilder: (context, index) {
                final note = box.getAt(index);
                if (note == null) return const SizedBox();

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailNotePage(
                          noteKey: note.id,
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
                            if (note.isFinished)
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 20,
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          note.body.length > 150
                              ? '${note.body.substring(0, 150)}...'
                              : note.body,
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
            decoration: BoxDecoration(
              color: const Color(0xFFFAF8FC),
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
                  MaterialPageRoute(builder: (_) => const CreateNotePage()),
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
  }
}

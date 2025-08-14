import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/note.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  late Box<Note> notesBox;

  @override
  void initState() {
    super.initState();
    notesBox = Hive.box<Note>('notes');
  }

  void _saveNoteAndBack() {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();

    if (title.isEmpty && body.isEmpty) {
      Navigator.pop(context);
      return;
    }

    final uuid = Uuid();
    final note = Note(
      id: uuid.v4(),
      title: title,
      body: body,
      isFinished: false,
      lastEdited: DateTime.now(),
    );

    notesBox.put(note.id, note);
    debugPrint("Note saved: $title");

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(
            color: Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: _saveNoteAndBack,
          child: Row(
            children: const [
              SizedBox(width: 8),
              Icon(Icons.chevron_left, color: Color(0xFF394675)),
              SizedBox(width: 4),
              Text(
                "Back",
                style: TextStyle(
                  color: Color(0xFF394675),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF180E25),
              ),
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: _bodyController,
                maxLines: null,
                expands: true,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF827D89),
                ),
                decoration: const InputDecoration(
                  hintText: "Write your note here...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

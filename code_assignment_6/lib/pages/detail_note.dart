import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import '../models/note.dart';

class DetailNotePage extends StatefulWidget {
  final String noteKey;

  const DetailNotePage({super.key, required this.noteKey});

  @override
  State<DetailNotePage> createState() => _DetailNotePageState();
}

class _DetailNotePageState extends State<DetailNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  late Box<Note> notesBox;
  late Note note;

  @override
  void initState() {
    super.initState();
    notesBox = Hive.box<Note>('notes');

    note = notesBox.get(widget.noteKey)!;

    _titleController = TextEditingController(text: note.title);
    _bodyController = TextEditingController(text: note.body);
  }

  void _updateNoteAndBack() {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();

    if (title.isEmpty && body.isEmpty) {
      Navigator.pop(context);
      return;
    }

    final updatedNote = Note(
      id: note.id,
      title: title,
      body: body,
      isFinished: note.isFinished,
      lastEdited: DateTime.now(),
    );

    notesBox.put(widget.noteKey, updatedNote);
    debugPrint("Note updated (UUID: ${widget.noteKey})");

    Navigator.pop(context);
  }

  void _showActionModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 64),
                  ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: Text(
                      note.isFinished ? "Mark as Unfinished" : "Mark as Finished",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      final updatedNote = Note(
                        id: note.id,
                        title: _titleController.text.trim(),
                        body: _bodyController.text.trim(),
                        isFinished: !note.isFinished,
                        lastEdited: DateTime.now(),
                      );
                      notesBox.put(widget.noteKey, updatedNote);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFEFEEF0),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    leading: const Icon(Icons.delete_outline, color: Color(0xFFCE3A54)),
                    title: Text(
                      "Delete Note",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFCE3A54),
                      ),
                    ),
                    onTap: () {
                      notesBox.delete(widget.noteKey);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEFEEF0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, size: 14, color: Color(0xFF827D89)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String getLastEditedText() {
    final edited = note.lastEdited ?? DateTime.now();
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
          bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: _updateNoteAndBack,
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
        padding: const EdgeInsets.only(bottom: 80.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _titleController,
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF180E25),
                ),
                decoration: const InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _bodyController,
                  maxLines: null,
                  expands: true,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF827D89),
                  ),
                  decoration: const InputDecoration(
                    hintText: "Write your note here...",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 48,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFFE0E0E0), width: 1),
          ),
        ),
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getLastEditedText(),
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: double.infinity,
              child: IconButton(
                padding: EdgeInsets.zero,
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFF394675),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: _showActionModal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

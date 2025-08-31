import 'package:code_assignment_8/models/note.dart';
import 'package:code_assignment_8/service/api_client.dart';
import 'package:dio/dio.dart';

class NoteAPIService {
  Future<List<Note>> fetchNotes() async {
    try {
      final response = await dio.get("/notes");
      final data = response.data["data"] as List;
      return data.map((json) => Note.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["meta"]?["message"] ?? "Failed to fetch notes",
      );
    }
  }

  Future<void> addNote(Note note) async {
    try {
      await dio.post("/notes", data: note.toJson());
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["meta"]?["message"] ?? "Failed to add note",
      );
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await dio.delete("/notes/$id");
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["meta"]?["message"] ?? "Failed to delete note",
      );
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      await dio.put("/notes/${note.id}", data: note.toJson());
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["meta"]?["message"] ?? "Failed to update note",
      );
    }
  }

  Future<void> toggleNote(String id, bool isFinished) async {
    try {
      await dio.patch("/notes/$id", data: {"isFinished": isFinished});
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["meta"]?["message"] ?? "Failed to toggle note",
      );
    }
  }
}

// note_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'note.dart';

class NoteCubit extends Cubit<List<Note>> {
  NoteCubit() : super([]) {
    loadNotes();
  }

  // Load notes from SharedPreferences
  void loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesData = prefs.getString('notes');
    if (notesData != null) {
      final List<dynamic> jsonList = jsonDecode(notesData);
      emit(jsonList.map((e) => Note.fromMap(e)).toList());
    }
  }

  // Save notes to SharedPreferences
  void saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = state.map((note) => note.toMap()).toList();
    prefs.setString('notes', jsonEncode(jsonList));
  }

  // Add a new note
  void addNote(String title) {
    final newNotes = [...state, Note(title: title)];
    emit(newNotes);
    saveNotes();
  }

  // Toggle note completion
  void toggleNoteStatus(int index) {
    final newNotes = [...state];
    newNotes[index].isDone = !newNotes[index].isDone;
    emit(newNotes);
    saveNotes();
  }

  // Delete a note
  void deleteNote(int index) {
    final newNotes = [...state]..removeAt(index);
    emit(newNotes);
    saveNotes();
  }
}

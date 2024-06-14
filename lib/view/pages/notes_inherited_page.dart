import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesInheritedPage extends InheritedWidget {
  final ValueNotifier<List<NoteModel>?> notes;

  NotesInheritedPage({
    super.key,
    required super.child,
  }) : notes = ValueNotifier(null) {
    SharedPreferences.getInstance().then((sp) async {
      final jsonString = sp.getString('notes');
      final notesList = jsonDecode(jsonString ?? '[]');

      final noteFromStorage = <NoteModel>[];

      for (final noteMap in notesList) {
        noteFromStorage.add(NoteModel.fromJson(noteMap));
      }

      notes.value = noteFromStorage;
    });
  }

  /// Save the notes to the shared preferences
  void saveNotes() async {
    final jsonString = jsonEncode(notes.value);

    final sp = await SharedPreferences.getInstance();
    sp.setString('notes', jsonString);
  }

  static NotesInheritedPage of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NotesInheritedPage>()!;
  }

  static NotesInheritedPage? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NotesInheritedPage>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    if (oldWidget is! NotesInheritedPage) {
      return false;
    }

    return false;
  }
}

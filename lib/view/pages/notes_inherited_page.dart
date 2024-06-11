import 'package:flutter/material.dart';
import 'package:notes_app/models/note_model.dart';

class NotesInheritedPage extends InheritedWidget {
  final ValueNotifier<List<NoteModel>> notes;

  NotesInheritedPage({
    super.key,
    required super.child,
  }) : notes = ValueNotifier([]);

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

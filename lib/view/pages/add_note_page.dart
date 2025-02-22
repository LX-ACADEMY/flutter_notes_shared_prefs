import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/view/pages/notes_inherited_page.dart';

class AddNotePage extends HookWidget {
  final int? noteIndex;
  final NoteModel? noteToEdit;

  const AddNotePage({
    super.key,
    this.noteToEdit,
    this.noteIndex,
  });

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();
    final contentController = useTextEditingController();
    final isEditMode = noteToEdit != null;

    void addNewNote() {
      final title = titleController.text;
      final content = contentController.text;

      final notesState = NotesInheritedPage.of(context).notes;

      if (isEditMode) {
        final newNotes = [...notesState.value!];
        newNotes[noteIndex!] = NoteModel(
          title: title,
          content: content,
        );

        notesState.value = newNotes;
      } else {
        notesState.value = [
          ...notesState.value ?? [],
          NoteModel(
            title: title,
            content: content,
          ),
        ];
      }

      Navigator.pop(context);

      NotesInheritedPage.of(context).saveNotes();
    }

    useEffect(() {
      if (isEditMode) {
        titleController.text = noteToEdit!.title;
        contentController.text = noteToEdit!.content;
      }

      return null;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit note' : 'Add new note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
            ),
            const Divider(),
            const SizedBox(height: 32),
            Expanded(
              child: TextField(
                controller: contentController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Content',
                  border: InputBorder.none,
                ),
                maxLines: null,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addNewNote,
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

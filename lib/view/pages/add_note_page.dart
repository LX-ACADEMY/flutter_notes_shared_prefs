import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/view/pages/notes_inherited_page.dart';

class AddNotePage extends HookWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();
    final contentController = useTextEditingController();

    void addNewNote() {
      final title = titleController.text;
      final content = contentController.text;

      final notesState = NotesInheritedPage.of(context).notes;

      notesState.value = [
        ...notesState.value,
        NoteModel(
          title: title,
          content: content,
        ),
      ];

      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new note'),
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

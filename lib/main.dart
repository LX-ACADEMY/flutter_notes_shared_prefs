import 'package:flutter/material.dart';
import 'package:notes_app/view/pages/home_page.dart';
import 'package:notes_app/view/pages/notes_inherited_page.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return NotesInheritedPage(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        title: 'Notes',
        home: const HomePage(),
      ),
    );
  }
}

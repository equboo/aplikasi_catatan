// ignore_for_file: camel_case_types, unused_element, unused_field

import 'package:belajar_pemula/class/notes_class.dart';
import 'package:belajar_pemula/database/helper.dart';
import 'package:belajar_pemula/pages/add_note_page.dart';
import 'package:belajar_pemula/pages/view_note_page.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final Helper _helper = Helper();
  List<Note> _notes = [];
  final List<Color> _notesColor = [
    const Color(0xff4db6ac),
    Colors.green,
    Colors.cyan,
    Colors.lightBlue,
    Colors.teal,
    Colors.teal.shade900,
    Colors.deepPurple
  ];

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final notes = await _helper.getNotes();
    setState(() {
      _notes = notes;
    });
  }

  String _dateTimeFormat(String dateTime) {
    final DateTime dt = DateTime.parse(dateTime);
    final now = DateTime.now();

    if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
      return 'today, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(0, '0')}';
    }
    return '${dt.day}/${dt.month}/${dt.year}, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(0, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade200,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Notes',
          style: TextStyle(
              color: Colors.green.shade100,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final notes = _notes[index];
          final color = Color(int.parse(notes.color));

          return GestureDetector(
            onTap: () async {
              _loadState();
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewNotePage(notes: notes)));
            },
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notes.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    notes.content,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    _dateTimeFormat(notes.dateTime),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNotePage(),
              ));
          _loadState();
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xff50c878),
        foregroundColor: Colors.white,
      ),
    );
  }
}

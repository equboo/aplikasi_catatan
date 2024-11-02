// ignore_for_file: use_key_in_widget_constructors

import 'package:belajar_pemula/class/notes_class.dart';
import 'package:belajar_pemula/database/helper.dart';
import 'package:belajar_pemula/pages/home_page.dart';
import 'package:flutter/material.dart';

class AddNotePage extends StatefulWidget {
  final Note? notes;
  const AddNotePage({this.notes});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final __formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final Helper _helper = Helper();
  Color _selectedColor = const Color(0xff4db6ac);
  final List<Color> _colors = [
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
    if (widget.notes != null) {
      _titleController.text = widget.notes!.title;
      _contentController.text = widget.notes!.content;
      _selectedColor = Color(
        int.parse(widget.notes!.color),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade200,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.notes == null ? 'Add Note' : 'Edit Note',
            style: TextStyle(
                color: Colors.green.shade100, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: __formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: "Title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter a title";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _contentController,
                      decoration: InputDecoration(
                        hintText: "Content",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 10,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter a content";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _colors.map(
                            (color) {
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedColor = color),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: color,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: _selectedColor == color
                                          ? Colors.black45
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _saveNotes();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => homePage()));
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xff50c878),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Save Note",
                      style: TextStyle(
                        color: Colors.green.shade100,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveNotes() async {
    if (__formKey.currentState!.validate()) {
      final notes = Note(
        id: widget.notes?.id,
        title: _titleController.text,
        content: _contentController.text,
        color: _selectedColor.value.toString(),
        dateTime: DateTime.now().toString(),
      );

      if (widget.notes == null) {
        await _helper.insertNotes(notes);
      } else {
        await _helper.updateNotes(notes);
      }
    }
  }
}

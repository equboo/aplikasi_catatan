// ignore_for_file: unused_element, use_key_in_widget_constructors, non_constant_identifier_names, use_build_context_synchronously

import 'package:belajar_pemula/class/notes_class.dart';
import 'package:belajar_pemula/database/helper.dart';
import 'package:belajar_pemula/pages/add_note_page.dart';
import 'package:flutter/material.dart';

class ViewNotePage extends StatelessWidget {
  final Note notes;
  ViewNotePage({required this.notes});

  final Helper _helper = Helper();

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
      backgroundColor: Color(int.parse(notes.color)),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNotePage(
                      notes: notes,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.edit)),
          IconButton(
            onPressed: () => _DeleteDialog(context),
            icon: const Icon(Icons.delete),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notes.title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _dateTimeFormat(notes.dateTime),
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                notes.content,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.8),
                  height: 1.6,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ))
        ],
      )),
    );
  }

  Future<void> _DeleteDialog(BuildContext context) async {
    final confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          "Delete dialog",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Are u sure want delete this note?",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              "Cancel",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              "Delete",
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
    if (confirm == true) {
      await _helper.deleteNotes(notes.id!);
      Navigator.pop(context);
    }
  }
}

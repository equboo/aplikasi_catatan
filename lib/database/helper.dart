import 'package:belajar_pemula/class/notes_class.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Helper {
  static final Helper _instance = Helper._internal();
  static Database? _database;

  factory Helper() => _instance;
  Helper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
  create  table Notes (
  id  integer primary key autoincrement,
  title text,
  content text,
  color text,
  dateTime text
  )
''');
  }

  Future<int> insertNotes(Note notes) async {
    final db = await database;
    return await db.insert("notes", notes.toMap());
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Notes');
    return List.generate(maps.length, (i) => Note.fromMap(maps[i]));
  }

  Future<int> updateNotes(Note notes) async {
    final db = await database;
    return await db.update(
      'Notes',
      notes.toMap(),
      where: 'id = ?',
      whereArgs: [notes.id],
    );
  }

  Future<int> deleteNotes(int id) async {
    final db = await database;
    return await db.delete(
      'Notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

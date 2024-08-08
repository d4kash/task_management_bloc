import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';

class TaskRepository {
  Database? _database;

  Future<Database> get _db async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'tasks.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS tasks ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'title TEXT, '
          'description TEXT, '
          'dueDate INTEGER, '
          'isCompleted INTEGER'
          ')',
        );
      },
    );
  }

  int _dateTimeToInt(DateTime dateTime) => dateTime.millisecondsSinceEpoch;

  DateTime _intToDateTime(int milliseconds) => DateTime.fromMillisecondsSinceEpoch(milliseconds);

  int _boolToInt(bool value) => value ? 1 : 0;

  bool _intToBool(int value) => value == 1;

  Future<void> insertTask(Task task) async {
    final db = await _db;
    await db.insert(
      'tasks',
      {
        // 'id': task.id,
        'title': task.title,
        'description': task.description,
        'dueDate': _dateTimeToInt(task.dueDate),
        'isCompleted': _boolToInt(task.isCompleted),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> fetchTasks() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (i) {
      final map = maps[i];
      return Task(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        dueDate: _intToDateTime(map['dueDate']),
        isCompleted: _intToBool(map['isCompleted']),
      );
    });
  }

  Future<void> updateTask(Task task) async {
    final db = await _db;
    await db.update(
      'tasks',
      {
        'title': task.title,
        'description': task.description,
        'dueDate': _dateTimeToInt(task.dueDate),
        'isCompleted': _boolToInt(task.isCompleted),
      },
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await _db;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

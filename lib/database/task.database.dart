import 'package:novo/database/scripts.dart';
import 'package:novo/domain/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TaskDatabase {
  static final TaskDatabase instance = TaskDatabase._init();
  static Database? _database;

  TaskDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase("myapp");
    return _database!;
  }

  Future<Database> _initDatabase(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(createTable);
  }

  Future<int> insert(Task value) async {
    final db = await instance.database;
    return db.insert("tasks", value.toJson());
  }

  Future<List<Task>> readALl() async {
    final db = await instance.database;
    final result = await db.query("tasks");
    return result.map((taskJson) => Task.fromJson(taskJson)).toList();
  }
}

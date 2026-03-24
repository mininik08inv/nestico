// lib/data/database/database_service.dart
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final path = join(docsDir.path, 'nestico.db');
    debugPrint(path);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Создаем все таблицы
    // await db.execute('''
    //   CREATE TABLE users(
    //     id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     name TEXT,
    //     email TEXT UNIQUE,
    //     created_at TEXT
    //   )
    // ''');

    await db.execute('''
      CREATE TABLE nests(
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        created_by TEXT,
        created_at TEXT,
        is_active INTEGER DEFAULT 1
      )
    ''');

    await db.execute('''
      CREATE TABLE tasks(
        id TEXT PRIMARY KEY,                    
        title TEXT,
        description TEXT,
        quadrant INTEGER,
        is_completed INTEGER DEFAULT 0,
        nest_id TEXT,
        created_at TEXT,
        created_by TEXT,
        due_date TEXT,
        updated_at TEXT,
        order_index INTEGER DEFAULT 0,
        FOREIGN KEY(nest_id) REFERENCES nests(id)
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Создаем новую таблицу с правильной структурой
      await db.execute('''
        CREATE TABLE tasks_new(
          id TEXT PRIMARY KEY,
          title TEXT,
          description TEXT,
          quadrant INTEGER,
          is_completed INTEGER DEFAULT 0,
          nest_id TEXT,
          created_at TEXT,
          created_by TEXT,
          due_date TEXT,
          updated_at TEXT,
          order_index INTEGER DEFAULT 0,
          FOREIGN KEY(nest_id) REFERENCES nests(id)
        )
      ''');

      // Копируем данные из старой таблицы (если нужно)
      await db.execute('''
        INSERT INTO tasks_new (id, title, description, quadrant, is_completed, nest_id, created_at, created_by)
        SELECT 
          hex(randomblob(16)), -- временно генерируем UUID для старых записей
          title, 
          description, 
          quadrant, 
          is_completed, 
          nest_id, 
          created_at, 
          created_by 
        FROM tasks
      ''');

      // Удаляем старую таблицу
      await db.execute('DROP TABLE tasks');

      // Переименовываем новую
      await db.execute('ALTER TABLE tasks_new RENAME TO tasks');
    }
  }

  // ---- RAW DATABASE METHODS ----
  // (низкоуровневые методы, используются репозиториями)

  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(table, data);
  }

  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await database;
    return await db.query(table, where: where, whereArgs: whereArgs);
  }

  Future<int> update(
    String table,
    Map<String, dynamic> data, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await database;
    return await db.update(table, data, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }
}

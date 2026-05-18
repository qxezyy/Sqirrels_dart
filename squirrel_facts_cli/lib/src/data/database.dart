import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'repositories/squirrel_repository.dart'; 

class SquirrelDatabase {
  final Database _db;

  SquirrelDatabase(String path) : _db = sqlite3.open(path) {
    _createTables();
  }

  factory SquirrelDatabase.inApp() {
    final path = p.join(Directory.current.path, 'squirrels.db');
    return SquirrelDatabase(path);
  }

  void _createTables() {
    _db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        full_name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        login TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        role TEXT NOT NULL DEFAULT 'user',
        created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
      );
    ''');

    _db.execute('''
      CREATE TABLE IF NOT EXISTS squirrel_facts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        user_id INTEGER REFERENCES users(id) ON DELETE SET NULL
      );
    ''');

    _db.execute('''
      CREATE TABLE IF NOT EXISTS squirrels (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        color TEXT
      );
    ''');

    _db.execute('''
      CREATE TABLE IF NOT EXISTS nuts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,
        stock INTEGER NOT NULL DEFAULT 0
      );
    ''');

    _db.execute('''
      CREATE TABLE IF NOT EXISTS squirrel_nut_preference (
        squirrel_id INTEGER REFERENCES squirrels(id) ON DELETE CASCADE,
        nut_id INTEGER REFERENCES nuts(id) ON DELETE CASCADE,
        PRIMARY KEY (squirrel_id, nut_id)
      );
    ''');
  }

  Database get db => _db;
  SquirrelRepository get repository => SquirrelRepository(_db);

  void close() => _db.dispose();
}
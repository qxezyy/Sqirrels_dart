import 'package:test/test.dart';
import '../lib/squirrel.dart';
import 'dart:io';

void main() {
  test('CRUD для белок', () {
    final dbFile = File('test_squirrels.db');
    final db = SquirrelDatabase(dbFile.path);
    final repo = db.repository;   

    repo.insertSquirrel(Squirrel(id: 1, name: 'Никита', color: 'серый'));
    repo.insertSquirrel(Squirrel(id: 2, name: 'Антон', color: 'Рыжий'));

    var list = repo.getAllSquirrels();
    expect(list.length, 2);
    expect(list[0].name, 'Никита');

    final s = repo.getSquirrel(1);
    expect(s?.color, 'серый');

    repo.updateSquirrel(Squirrel(id: 1, name: 'Никита Великий', color: 'серенький'));
    final updated = repo.getSquirrel(1);
    expect(updated?.name, 'Никита Великий');

    repo.deleteSquirrel(1);
    list = repo.getAllSquirrels();
    expect(list.length, 1);
    expect(list[0].id, 2);

    db.close();
    dbFile.deleteSync();
  });
}
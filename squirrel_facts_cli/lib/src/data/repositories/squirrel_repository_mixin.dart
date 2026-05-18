import '../../domain/models/squirrel.dart';
import 'repository_base.dart';

mixin SquirrelRepositoryMixin on RepositoryBase {
  void insertSquirrel(Squirrel squirrel) {
    database.execute(
      'INSERT OR REPLACE INTO squirrels (id, name, color) VALUES (?,?,?)',
      [squirrel.id, squirrel.name, squirrel.color],
    );
  }

  List<Squirrel> getAllSquirrels() {
    final rows = database.select('SELECT * FROM squirrels');
    return rows.map((row) => Squirrel.fromMap(row)).toList();
  }

  Squirrel? getSquirrel(int id) {
    final rows = database.select('SELECT * FROM squirrels WHERE id = ?', [id]);
    return rows.isNotEmpty ? Squirrel.fromMap(rows.first) : null;
  }

  void updateSquirrel(Squirrel squirrel) {
    database.execute(
      'UPDATE squirrels SET name = ?, color = ? WHERE id = ?',
      [squirrel.name, squirrel.color, squirrel.id],
    );
  }

  void deleteSquirrel(int id) {
    database.execute('DELETE FROM squirrels WHERE id = ?', [id]);
  }
}
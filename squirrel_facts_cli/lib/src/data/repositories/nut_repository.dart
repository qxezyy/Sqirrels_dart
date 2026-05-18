import '../../domain/models/nut.dart';
import 'repository_base.dart';

mixin NutRepository on RepositoryBase {
  void insertNut(Nut nut) {
    database.execute(
      'INSERT OR REPLACE INTO nuts (id, type, stock) VALUES (?,?,?)',
      [nut.id, nut.type, nut.stock],
    );
  }

  List<Nut> getAllNuts() {
    final rows = database.select('SELECT * FROM nuts');
    return rows.map((row) => Nut.fromMap(row)).toList();
  }

  Nut? getNut(int id) {
    final rows = database.select('SELECT * FROM nuts WHERE id = ?', [id]);
    return rows.isNotEmpty ? Nut.fromMap(rows.first) : null;
  }

  void updateNut(Nut nut) {
    database.execute(
      'UPDATE nuts SET type = ?, stock = ? WHERE id = ?',
      [nut.type, nut.stock, nut.id],
    );
  }

  void deleteNut(int id) {
    database.execute('DELETE FROM nuts WHERE id = ?', [id]);
  }
}
import '../../domain/models/squirrel_fact.dart';
import 'repository_base.dart';

mixin SquirrelFactRepository on RepositoryBase {
  void insertSquirrelFact(SquirrelFact fact) {
    database.execute(
      'INSERT OR REPLACE INTO squirrel_facts (id, title, description, user_id) VALUES (?,?,?,?)',
      [fact.id, fact.title, fact.description, fact.userId],
    );
  }

  List<SquirrelFact> getAllSquirrelFacts() {
    final rows = database.select('SELECT * FROM squirrel_facts');
    return rows.map((row) => SquirrelFact.fromMap(row)).toList();
  }

  SquirrelFact? getSquirrelFact(int id) {
    final rows = database.select('SELECT * FROM squirrel_facts WHERE id = ?', [id]);
    return rows.isNotEmpty ? SquirrelFact.fromMap(rows.first) : null;
  }

  void updateSquirrelFact(SquirrelFact fact) {
    database.execute(
      'UPDATE squirrel_facts SET title = ?, description = ?, user_id = ? WHERE id = ?',
      [fact.title, fact.description, fact.userId, fact.id],
    );
  }

  void deleteSquirrelFact(int id) {
    database.execute('DELETE FROM squirrel_facts WHERE id = ?', [id]);
  }
}
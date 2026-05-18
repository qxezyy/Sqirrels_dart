import '../../domain/models/squirrel_nut_preference.dart';
import 'repository_base.dart';

mixin PreferenceRepository on RepositoryBase {
  void insertPreference(int squirrelId, int nutId) {
    database.execute(
      'INSERT OR IGNORE INTO squirrel_nut_preference (squirrel_id, nut_id) VALUES (?,?)',
      [squirrelId, nutId],
    );
  }

  List<SquirrelNutPreference> getAllPreferences() {
    final rows = database.select('SELECT squirrel_id, nut_id FROM squirrel_nut_preference');
    return rows.map((row) => SquirrelNutPreference.fromMap(row)).toList();
  }

  List<SquirrelNutPreference> getPreferencesBySquirrel(int squirrelId) {
    final rows = database.select(
      'SELECT squirrel_id, nut_id FROM squirrel_nut_preference WHERE squirrel_id = ?',
      [squirrelId],
    );
    return rows.map((row) => SquirrelNutPreference.fromMap(row)).toList();
  }

  void deletePreference(int squirrelId, int nutId) {
    database.execute(
      'DELETE FROM squirrel_nut_preference WHERE squirrel_id = ? AND nut_id = ?',
      [squirrelId, nutId],
    );
  }

  void deletePreferencesBySquirrel(int squirrelId) {
    database.execute('DELETE FROM squirrel_nut_preference WHERE squirrel_id = ?', [squirrelId]);
  }
}
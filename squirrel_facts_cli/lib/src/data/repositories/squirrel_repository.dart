import 'package:sqlite3/sqlite3.dart';
import 'repository_base.dart';
import 'user_repository.dart';
import 'squirrel_repository_mixin.dart';
import 'nut_repository.dart';
import 'squirrel_fact_repository.dart';
import 'preference_repository.dart';

class SquirrelRepository extends RepositoryBase
    with
        UserRepository,
        SquirrelRepositoryMixin,
        NutRepository,
        SquirrelFactRepository,
        PreferenceRepository {
  SquirrelRepository(this._database);

  final Database _database;

  @override
  Database get database => _database;
}
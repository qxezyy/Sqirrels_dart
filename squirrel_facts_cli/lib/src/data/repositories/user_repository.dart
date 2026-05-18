import '../../domain/models/user.dart';
import 'repository_base.dart';

mixin UserRepository on RepositoryBase {
  void insertUser(User user) {
    database.execute(
      'INSERT OR REPLACE INTO users (id, full_name, email, login, password, role, created_at) VALUES (?,?,?,?,?,?,?)',
      [user.id, user.fullName, user.email, user.login, user.password, user.role, user.createdAt.toIso8601String()],
    );
  }

  List<User> getAllUsers() {
    final rows = database.select('SELECT * FROM users');
    return rows.map((row) => User.fromMap(row)).toList();
  }

  User? getUser(int id) {
    final rows = database.select('SELECT * FROM users WHERE id = ?', [id]);
    return rows.isNotEmpty ? User.fromMap(rows.first) : null;
  }

  void updateUser(User user) {
    database.execute(
      'UPDATE users SET full_name = ?, email = ?, login = ?, password = ?, role = ? WHERE id = ?',
      [user.fullName, user.email, user.login, user.password, user.role, user.id],
    );
  }

  void deleteUser(int id) {
    database.execute('DELETE FROM users WHERE id = ?', [id]);
  }
}
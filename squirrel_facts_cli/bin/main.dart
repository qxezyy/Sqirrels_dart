import 'package:squirrel_facts_cli/squirrel.dart';

void main(List<String> arguments) {
  final db = SquirrelDatabase.inApp();
  try {
    runMenu(db);
  } finally {
    db.close();
  }
}
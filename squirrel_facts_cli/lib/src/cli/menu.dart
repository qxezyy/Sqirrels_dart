import 'dart:io';
import '../data/database.dart';
import '../domain/models/squirrel.dart';
import '../domain/models/nut.dart';
import '../domain/models/squirrel_fact.dart';
import '../domain/models/user.dart';
import '../data/repositories/squirrel_repository.dart';
import 'input_helper.dart';

void runMenu(SquirrelDatabase db) {
  final repo = db.repository; 

  while (true) {
    stdout.writeln('''
--- Учёт белок и орехов ---
1 — список белок
2 — добавить белку
3 — удалить белку по id
4 — список орехов
5 — добавить орех
6 — удалить орех по id
7 — список фактов
8 — добавить факт
9 — удалить факт по id
10 — список пользователей
11 — добавить пользователя
12 — удалить пользователя по id
13 — список предпочтений
14 — добавить предпочтение (белка -> орех)
15 — удалить предпочтение
16 — показать всё из базы
0 — выход
Выберите пункт:''');

    final choice = stdin.readLineSync()?.trim() ?? '';
    switch (choice) {
      case '1':
        _printSquirrels(repo);
        break;
      case '2':
        _addSquirrel(repo);
        break;
      case '3':
        _deleteSquirrel(repo);
        break;
      case '4':
        _printNuts(repo);
        break;
      case '5':
        _addNut(repo);
        break;
      case '6':
        _deleteNut(repo);
        break;
      case '7':
        _printFacts(repo);
        break;
      case '8':
        _addFact(repo);
        break;
      case '9':
        _deleteFact(repo);
        break;
      case '10':
        _printUsers(repo);
        break;
      case '11':
        _addUser(repo);
        break;
      case '12':
        _deleteUser(repo);
        break;
      case '13':
        _printPreferences(repo);
        break;
      case '14':
        _addPreference(repo);
        break;
      case '15':
        _deletePreference(repo);
        break;
      case '16':
        _printAllFromDb(repo);
        break;
      case '0':
        stdout.writeln('До свидания.');
        return;
      default:
        stdout.writeln('Неизвестная команда.');
    }
    stdout.writeln();
  }
}

void _printSquirrels(SquirrelRepository repo) {
  final list = repo.getAllSquirrels();
  if (list.isEmpty) {
    stdout.writeln('Белок нет.');
    return;
  }
  for (final s in list) {
    stdout.writeln('id: ${s.id} | ${s.name} | окрас: ${s.color ?? "не указан"}');
  }
}

void _addSquirrel(SquirrelRepository repo) {
  final id = askPositiveInt('id белки (целое число >0): ', 'id');
  final name = askString('имя: ', 'имя');
  final color = askString('окрас (можно пропустить): ', 'окрас');
  repo.insertSquirrel(Squirrel(
    id: id,
    name: name,
    color: color.isEmpty ? null : color,
  ));
  stdout.writeln('Белка сохранена.');
}

void _deleteSquirrel(SquirrelRepository repo) {
  final id = askPositiveInt('id белки для удаления: ', 'id');
  repo.deleteSquirrel(id);
  stdout.writeln('Готово (если id был в базе).');
}

void _printNuts(SquirrelRepository repo) {
  final list = repo.getAllNuts();
  if (list.isEmpty) {
    stdout.writeln('Орехов нет.');
    return;
  }
  for (final n in list) {
    stdout.writeln('id: ${n.id} | ${n.type} | запас: ${n.stock}');
  }
}

void _addNut(SquirrelRepository repo) {
  final id = askPositiveInt('id ореха (целое число >0): ', 'id');
  final type = askString('тип ореха: ', 'тип');
  final stock = askPositiveInt('запас (>0): ', 'запас');
  repo.insertNut(Nut(id: id, type: type, stock: stock));
  stdout.writeln('Орех сохранён.');
}

void _deleteNut(SquirrelRepository repo) {
  final id = askPositiveInt('id ореха для удаления: ', 'id');
  repo.deleteNut(id);
  stdout.writeln('Готово (если id был в базе).');
}

void _printFacts(SquirrelRepository repo) {
  final list = repo.getAllSquirrelFacts();
  if (list.isEmpty) {
    stdout.writeln('Фактов нет.');
    return;
  }
  for (final f in list) {
    stdout.writeln('id: ${f.id} | ${f.title} | автор id: ${f.userId ?? "аноним"}');
    if (f.description != null) {
      stdout.writeln('    описание: ${f.description}');
    }
  }
}

void _addFact(SquirrelRepository repo) {
  final id = askPositiveInt('id факта: ', 'id');
  final title = askString('заголовок: ', 'заголовок');
  final description = askString('описание (можно пропустить): ', 'описание');
  stdout.writeln('Доступные пользователи:');
  _printUsers(repo);
  final userId = askPositiveInt('id автора (0 — без автора): ', 'id автора');
  repo.insertSquirrelFact(SquirrelFact(
    id: id,
    title: title,
    description: description.isEmpty ? null : description,
    userId: userId == 0 ? null : userId,
  ));
  stdout.writeln('Факт сохранён.');
}

void _deleteFact(SquirrelRepository repo) {
  final id = askPositiveInt('id факта для удаления: ', 'id');
  repo.deleteSquirrelFact(id);
  stdout.writeln('Готово (если id был в базе).');
}

void _printUsers(SquirrelRepository repo) {
  final list = repo.getAllUsers();
  if (list.isEmpty) {
    stdout.writeln('Пользователей нет.');
    return;
  }
  for (final u in list) {
    stdout.writeln('id: ${u.id} | ${u.fullName} | ${u.login} | роль: ${u.role}');
  }
}

void _addUser(SquirrelRepository repo) {
  final id = askPositiveInt('id пользователя: ', 'id');
  final fullName = askString('полное имя: ', 'полное имя');
  final email = askString('email: ', 'email');
  final login = askString('логин: ', 'логин');
  final password = askString('пароль: ', 'пароль');
  final role = askString('роль (user/admin): ', 'роль');
  repo.insertUser(User(
    id: id,
    fullName: fullName,
    email: email,
    login: login,
    password: password,
    role: role,
    createdAt: DateTime.now(),
  ));
  stdout.writeln('Пользователь сохранён.');
}

void _deleteUser(SquirrelRepository repo) {
  final id = askPositiveInt('id пользователя для удаления: ', 'id');
  repo.deleteUser(id);
  stdout.writeln('Готово (если id был в базе).');
}

void _printPreferences(SquirrelRepository repo) {
  final list = repo.getAllPreferences();
  if (list.isEmpty) {
    stdout.writeln('Предпочтений нет.');
    return;
  }
  for (final p in list) {
    stdout.writeln('белка ${p.squirrelId} -> орех ${p.nutId}');
  }
}

void _addPreference(SquirrelRepository repo) {
  stdout.writeln('Доступные белки:');
  _printSquirrels(repo);
  stdout.writeln('Доступные орехи:');
  _printNuts(repo);
  final squirrelId = askPositiveInt('id белки: ', 'id белки');
  final nutId = askPositiveInt('id ореха: ', 'id ореха');
  repo.insertPreference(squirrelId, nutId);
  stdout.writeln('Предпочтение добавлено.');
}

void _deletePreference(SquirrelRepository repo) {
  final squirrelId = askPositiveInt('id белки: ', 'id белки');
  final nutId = askPositiveInt('id ореха: ', 'id ореха');
  repo.deletePreference(squirrelId, nutId);
  stdout.writeln('Предпочтение удалено (если существовало).');
}

void _printAllFromDb(SquirrelRepository repo) {
  stdout.writeln('Пользователи');
  _printUsers(repo);
  stdout.writeln('Белки');
  _printSquirrels(repo);
  stdout.writeln('Орехи');
  _printNuts(repo);
  stdout.writeln('Факты');
  _printFacts(repo);
  stdout.writeln('Предпочтения');
  _printPreferences(repo);
}
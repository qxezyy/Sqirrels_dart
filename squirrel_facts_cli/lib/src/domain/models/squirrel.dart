import 'identity.dart';

class Squirrel implements Identity {
  @override
  final int id;
  final String name;
  final String? color;

  Squirrel({required this.id, required this.name, this.color});

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'color': color,
      };

  factory Squirrel.fromMap(Map<String, dynamic> map) {
    return Squirrel(
      id: map['id'] as int,
      name: map['name'] as String,
      color: map['color'] as String?,
    );
  }

  @override
  String toString() => '$name (${color ?? "цвет не указан"})';
}
import 'identity.dart';

class Nut implements Identity {
  @override
  final int id;
  final String type;
  final int stock;

  Nut({required this.id, required this.type, required this.stock});

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'stock': stock,
      };

  factory Nut.fromMap(Map<String, dynamic> map) {
    return Nut(
      id: map['id'] as int,
      type: map['type'] as String,
      stock: map['stock'] as int,
    );
  }

  @override
  String toString() => '$type (запас: $stock)';
}
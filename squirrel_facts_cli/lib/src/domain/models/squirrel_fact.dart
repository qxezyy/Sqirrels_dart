import 'identity.dart';

class SquirrelFact implements Identity {
  @override
  final int id;
  final String title;
  final String? description;
  final int? userId;

  SquirrelFact({
    required this.id,
    required this.title,
    this.description,
    this.userId,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'user_id': userId,
      };

  factory SquirrelFact.fromMap(Map<String, dynamic> map) {
    return SquirrelFact(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String?,
      userId: map['user_id'] as int?,
    );
  }

  @override
  String toString() => '$title (id: $id)';
}
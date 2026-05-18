class SquirrelNutPreference {
  final int squirrelId;
  final int nutId;

  SquirrelNutPreference({required this.squirrelId, required this.nutId});

  Map<String, dynamic> toMap() => {
        'squirrel_id': squirrelId,
        'nut_id': nutId,
      };

  factory SquirrelNutPreference.fromMap(Map<String, dynamic> map) {
    return SquirrelNutPreference(
      squirrelId: map['squirrel_id'] as int,
      nutId: map['nut_id'] as int,
    );
  }
}
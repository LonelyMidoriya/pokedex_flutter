class Pokemon{
  int id;
  int height;
  String name;
  int hpStat;
  int attackStat;
  int defenseStat;
  int spAttackStat;
  int spDefStat;
  int speedStat;
  int weight;
  List<String> types;

  Pokemon({required this.id, required this.height, required this.name, required this.hpStat, required this.attackStat,
  required this.defenseStat, required this.spAttackStat, required this.spDefStat, required this.speedStat, required this.weight, required this.types});

  factory Pokemon.fromJson(Map<String, dynamic> map) {
    return Pokemon(
      id: map['id'],
      height: map['height'],
      name: map['name'],
      hpStat: map['hpStat'],
      attackStat: map['attackStat'],
      defenseStat: map['defenseStat'],
      spAttackStat: map['spAttackStat'],
      spDefStat: map['spDefStat'],
      speedStat: map['speedStat'],
      weight: map['weight'],
      types: map['types'].split('/'),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'height': height,
      'name': name,
      'hpStat': hpStat,
      'attackStat': attackStat,
      'defenseStat': defenseStat,
      'spAttackStat': spAttackStat,
      'spDefStat': spDefStat,
      'speedStat': speedStat,
      'weight': weight,
      'types': types.join('/'),
    };
  }
}
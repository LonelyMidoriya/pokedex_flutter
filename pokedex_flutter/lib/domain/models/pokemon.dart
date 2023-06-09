class Pokemon {
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

  Pokemon(
      {required this.id,
      required this.height,
      required this.name,
      required this.hpStat,
      required this.attackStat,
      required this.defenseStat,
      required this.spAttackStat,
      required this.spDefStat,
      required this.speedStat,
      required this.weight,
      required this.types});
}

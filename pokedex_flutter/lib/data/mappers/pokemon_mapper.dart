import '../../domain/models/pokemon.dart';

class PokemonMapper{
  Pokemon toPokemon(Map<String, dynamic> map) {
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

  Map<String, dynamic> toMap(Pokemon pokemon) {
    return {
      'id': pokemon.id,
      'height': pokemon.height,
      'name': pokemon.name,
      'hpStat': pokemon.hpStat,
      'attackStat': pokemon.attackStat,
      'defenseStat': pokemon.defenseStat,
      'spAttackStat': pokemon.spAttackStat,
      'spDefStat': pokemon.spDefStat,
      'speedStat': pokemon.speedStat,
      'weight': pokemon.weight,
      'types': pokemon.types.join('/'),
    };
  }
}
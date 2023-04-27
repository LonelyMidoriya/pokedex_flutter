import '../../domain/models/pokemon_entry.dart';

class PokemonEntryMapper{
  PokemonEntry toPokemonEntry(Map<String, dynamic> map) {
    return PokemonEntry(
      name: map['name'],
      url: map['url'],
      id: map['id'],
    );
  }
  Map<String, dynamic> toMap(PokemonEntry pokemonEntry) {
    return {
      'name': pokemonEntry.name,
      'url': pokemonEntry.url,
      'id': pokemonEntry.id,
    };
  }
}
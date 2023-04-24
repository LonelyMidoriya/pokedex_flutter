import '../../../../domain/models/pokemon_entry.dart';

class PokemonState {
  List<PokemonEntry> pokemonEntries;
  final int pagesNumber;

  PokemonState({
    required this.pokemonEntries,
    required this.pagesNumber,
  });

  PokemonState copyWith({
    List<PokemonEntry>? pokemonEntries,
    int? pagesNumber,
  }) =>
      PokemonState(
        pokemonEntries: pokemonEntries ?? this.pokemonEntries,
        pagesNumber: pagesNumber ?? this.pagesNumber,
      );
}

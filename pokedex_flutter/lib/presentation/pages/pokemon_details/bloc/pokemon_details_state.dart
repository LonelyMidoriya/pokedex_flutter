import '../../../../domain/models/pokemon.dart';

class PokemonDetailsState {
  final Pokemon? pokemon;

  PokemonDetailsState({
    this.pokemon,
  });

  PokemonDetailsState copyWith({
    Pokemon? pokemon,
  }) =>
      PokemonDetailsState(
        pokemon: pokemon ?? this.pokemon,
      );
}

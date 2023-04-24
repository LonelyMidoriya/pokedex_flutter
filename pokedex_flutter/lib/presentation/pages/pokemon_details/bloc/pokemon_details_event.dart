abstract class PokemonDetailsEvent {}

class PokemonDetailsRequest extends PokemonDetailsEvent {
  final int id;

  PokemonDetailsRequest({
    required this.id,
  });
}

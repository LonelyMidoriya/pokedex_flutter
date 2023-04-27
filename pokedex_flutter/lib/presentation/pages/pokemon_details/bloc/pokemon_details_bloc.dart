import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/domain/models/pokemon.dart';
import 'package:pokedex_flutter/presentation/pages/pokemon_details/bloc/pokemon_details_event.dart';
import 'package:pokedex_flutter/presentation/pages/pokemon_details/bloc/pokemon_details_state.dart';

import '../../../../domain/repository/pokemon_repository.dart';

class PokemonDetailsBloc
    extends Bloc<PokemonDetailsEvent, PokemonDetailsState> {
  final PokemonRepository _pokemonRepository;

  PokemonDetailsBloc(this._pokemonRepository)
      : super(
          PokemonDetailsState(),
        ) {
    on<PokemonDetailsEvent>(_handleEvent);
  }

  void _handleEvent(
    PokemonDetailsEvent event,
    Emitter<PokemonDetailsState> emit,
  ) async {
    if (event is PokemonDetailsRequest) {
      await fetchPokemon(event.id, emit);
    }
  }

  Future<void> fetchPokemon(int id, Emitter<PokemonDetailsState> emit) async {
    Pokemon pokemon;
    try {
      pokemon = await _pokemonRepository.getPokemon(id);
    } catch (e) {
      pokemon = await _pokemonRepository.getPokemonFromDB(id);
    }

    emit(
      state.copyWith(
        pokemon: pokemon,
      ),
    );
  }
}

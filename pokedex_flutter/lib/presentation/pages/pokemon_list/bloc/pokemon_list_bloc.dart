import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/presentation/pages/pokemon_list/bloc/pokemon_list_state.dart';

import '../../../../domain/models/pokemon_entry.dart';
import '../../../../domain/pokemon_repository.dart';
import '../../pokemon_details/ui/pokemon_details_screen.dart';
import 'pokemon_list_event.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository _pokemonRepository;

  PokemonBloc(this._pokemonRepository)
      : super(
          PokemonState(
            pokemonEntries: [],
            pagesNumber: 1,
          ),
        ) {
    on<PokemonEvent>(_handleEvent);
  }

  void _handleEvent(
    PokemonEvent event,
    Emitter<PokemonState> emit,
  ) async {
    if (event is PokemonInitialEvent) {
      await initPagesNumber(emit);
      await fetchList(
        event.page,
        emit,
      );
    }
    if (event is PokemonLoadingEvent) {
      await fetchList(
        event.page,
        emit,
      );
    }
    if (event is NavigateToChosenPokemonEvent) {
      navigateToChosenPokemon(event);
    }
  }

  Future<void> initPagesNumber(Emitter<PokemonState> emit) async {
    int pagesCount;
    try{
      pagesCount = await _pokemonRepository.getPagesCount();
    }
    catch(e){
      pagesCount = await _pokemonRepository.getPagesCountFromDB();
    }
    emit(
      state.copyWith(
        pagesNumber: pagesCount,
      ),
    );
  }

  Future<void> fetchList(
    int page,
    Emitter<PokemonState> emit,
  ) async {
    List<PokemonEntry> pokemonList;
    try {
      pokemonList = await _pokemonRepository.getPokemonList(page);
    } catch (e) {
      pokemonList = await _pokemonRepository.getPokemonListFromDB(page);
    }
    state.pokemonEntries = pokemonList;
    emit(state.copyWith());
  }

  void navigateToChosenPokemon(NavigateToChosenPokemonEvent event) {
    Navigator.of(event.context).push(
      MaterialPageRoute(
        builder: (_) => PokemonScreen(
          id: event.id,
        ),
      ),
    );
  }
}
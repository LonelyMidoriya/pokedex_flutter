import 'package:get_it/get_it.dart';
import 'package:pokedex_flutter/data/mappers/pokemon_entry_mapper.dart';

void initPokemonEntryMapper() {
  GetIt.I.registerSingleton<PokemonEntryMapper>(
    PokemonEntryMapper(),
  );
}
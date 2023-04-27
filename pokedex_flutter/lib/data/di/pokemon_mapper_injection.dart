import 'package:get_it/get_it.dart';
import 'package:pokedex_flutter/data/mappers/pokemon_mapper.dart';

void initPokemonMapper() {
  GetIt.I.registerSingleton<PokemonMapper>(
    PokemonMapper(),
  );
}
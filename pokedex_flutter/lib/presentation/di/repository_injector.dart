import 'package:get_it/get_it.dart';
import 'package:pokedex_flutter/data/api/api.dart';
import '../../data/repository/pokemon_repository_impl.dart';
import '../../domain/pokemon_repository.dart';

void initRepository() {
  GetIt.I.registerSingleton<PokemonRepository>(
    PokemonRepositoryImpl(
      GetIt.I.get<NetworkHelper>(),
    ),
  );
}

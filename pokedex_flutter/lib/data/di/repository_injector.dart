import 'package:get_it/get_it.dart';
import 'package:pokedex_flutter/data/api/api.dart';
import '../repository/pokemon_repository_impl.dart';
import '../../domain/repository/pokemon_repository.dart';

void initRepository() {
  GetIt.I.registerSingleton<PokemonRepository>(
    PokemonRepositoryImpl(
      GetIt.I.get<NetworkHelper>(),
    ),
  );
}

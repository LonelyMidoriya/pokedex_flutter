import 'package:pokedex_flutter/data/di/pokemon_entry_mapper_injection.dart';
import 'package:pokedex_flutter/data/di/pokemon_mapper_injection.dart';
import 'package:pokedex_flutter/data/di/repository_injector.dart';
import 'api_injector.dart';
import 'db_injector.dart';

Future<void> initInjectors() async {
  initApi();
  initPokemonMapper();
  initPokemonEntryMapper();
  await initDb();
  initRepository();
}
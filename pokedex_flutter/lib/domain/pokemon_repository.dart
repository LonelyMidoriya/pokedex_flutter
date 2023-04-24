import 'models/pokemon.dart';
import 'models/pokemon_entry.dart';

abstract class PokemonRepository{
  Future<List<PokemonEntry>> getPokemonList(int pageIndex);
  Future<int> getPagesCount();
  Future<List<PokemonEntry>> getPokemonListFromDB(int pageIndex);
  Future<Pokemon> getPokemonFromDB(int id);
  Future<Pokemon> getPokemon(int id);
  Future<int> getPagesCountFromDB();
}
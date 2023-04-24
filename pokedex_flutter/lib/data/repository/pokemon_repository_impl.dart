import '../../domain/models/pokemon.dart';
import '../../domain/models/pokemon_entry.dart';
import '../../domain/pokemon_repository.dart';
import '../../presentation/utils/Consts.dart';
import '../api/api.dart';
import '../db/database.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final NetworkHelper networkHelper;

  PokemonRepositoryImpl(this.networkHelper);

  @override
  Future<List<PokemonEntry>> getPokemonList(int pageIndex) async {
    try {
      var pokemonData = await networkHelper
          .getData('/pokemon?limit=$pageSize&offset=${pageIndex * pageSize}');
      List<PokemonEntry> datas = [];
      for (var i = 0; i < pageSize; i++) {
        datas.add(
          PokemonEntry(
              name: pokemonData['results'][i]['name'],
              url: pokemonData['results'][i]['url'],
              id: int.parse(pokemonData['results'][i]['url']
                  .replaceAll(RegExp(r'[^0-9]'), '')
                  .substring(1))),
        );
      }
      for (var element in datas) {
        await DatabaseRepository.instance.insertPokemonList(pokemon: element);
      }
      return datas;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> getPagesCount() async {
    try {
      var pokemonData =
          await networkHelper.getData('/pokemon?limit=100000&offset=0');
      await DatabaseRepository.instance.insertPagesCount(
          pagesCount: (pokemonData['count'] / pageSize).toInt());
      return ((pokemonData['count'] / pageSize).toInt());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> getPagesCountFromDB() async {
    try {
      int pagesCount = await DatabaseRepository.instance.getPagesCount();
      return pagesCount;
    } catch (e) {
      return 1;
    }
  }

  @override
  Future<List<PokemonEntry>> getPokemonListFromDB(int pageIndex) async {
    try {
      List<PokemonEntry> pokemonList = await DatabaseRepository.instance
          .getPokemonList(pageSize, pageSize * pageIndex);
      return pokemonList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Pokemon> getPokemonFromDB(int id) async {
    try {
      return await DatabaseRepository.instance.getPokemon(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Pokemon> getPokemon(int id) async {
    try {
      var pokemonData = await networkHelper.getData('/pokemon/$id');
      List<String> pokemonTypes = [];
      List<dynamic> pokemonTypesList = pokemonData['types'];
      for (var i = 0; i < pokemonTypesList.length; i++) {
        if (pokemonData['types'][i] != null) {
          pokemonTypes.add(pokemonData['types'][i]['type']['name']);
        } else {
          break;
        }
      }
      Pokemon pokemon = Pokemon(
          id: pokemonData['id'],
          height: pokemonData['height'],
          weight: pokemonData['weight'],
          attackStat: pokemonData['stats'][1]['base_stat'],
          defenseStat: pokemonData['stats'][2]['base_stat'],
          hpStat: pokemonData['stats'][0]['base_stat'],
          name: pokemonData['name'],
          spAttackStat: pokemonData['stats'][3]['base_stat'],
          spDefStat: pokemonData['stats'][4]['base_stat'],
          speedStat: pokemonData['stats'][5]['base_stat'],
          types: pokemonTypes);

      await DatabaseRepository.instance.insertPokemon(pokemon: pokemon);
      return pokemon;
    } catch (e) {
      rethrow;
    }
  }
}

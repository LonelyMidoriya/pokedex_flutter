import '../pages/PokemonListScreen.dart';
import '../utils/Consts.dart';
import 'Api.dart';
import 'models/Pokemon.dart';
import 'models/PokemonEntry.dart';

const url = 'https://pokeapi.co/api/v2/';


class PokemonRepository {


  Future<List<PokemonEntry>> getPokemonList(int pageIndex) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$url/pokemon?limit=$pageSize&offset=${pageIndex * pageSize}');

    var pokemonData = await networkHelper.getData();
    List<PokemonEntry> datas = [];
    if(pokemonData!=null){
    for (var i = 0; i < pageSize; i++) {
      datas.add(PokemonEntry(
          name: pokemonData['results'][i]['name'], url: pokemonData['results'][i]['url']));
    }
    }
    return datas;
  }

  Future<Pokemon> getPokemon(String url) async {
    NetworkHelper networkHelper = NetworkHelper(url);

    var pokemonData = await networkHelper.getData();
    if(pokemonData==null){
      return Pokemon(id: 0, height: 0, name: "Connection Error", hpStat: 0, attackStat: 0, defenseStat: 0,
          spAttackStat: 0, spDefStat: 0, speedStat: 0, weight: 0, types: ['error']);
    }
    List<String> pokemonTypes = [];
    List<dynamic> pokemonTypesList = pokemonData['types'];
    for(var i = 0; i < pokemonTypesList.length; i++){
      if(pokemonData['types'][i]!=null){
        pokemonTypes.add(pokemonData['types'][i]['type']['name']);
      }
      else {
        break;
      }
    }

    return Pokemon(id: pokemonData['id'],height: pokemonData['height'],weight: pokemonData['weight'],
        attackStat:pokemonData['stats'][1]['base_stat'],defenseStat:pokemonData['stats'][2]['base_stat'],
        hpStat:pokemonData['stats'][0]['base_stat'],name: pokemonData['name'],spAttackStat: pokemonData['stats'][3]['base_stat'],
        spDefStat:pokemonData['stats'][4]['base_stat'],speedStat: pokemonData['stats'][5]['base_stat'],types: pokemonTypes);
  }
}

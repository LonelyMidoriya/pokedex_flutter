import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/data/DataBase.dart';
import 'package:pokedex_flutter/data/PokemonRepository.dart';
import 'package:pokedex_flutter/pages/PokemonScreen.dart';
import '../data/models/Pokemon.dart';
import '../data/models/PokemonEntry.dart';
import '../utils/ColorConverter.dart';

class GridItem extends StatelessWidget {
  final PokemonEntry entry;
  GridItem(this.entry);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          color: Color(0xffdcec5fa)),
      child: TextButton(
        onPressed: () async {
          int pokemonNumber = int.parse(entry.url.replaceAll(RegExp(r'[^0-9]'),'').substring(1));
          Pokemon pokemon = await getPokemon(pokemonNumber);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PokemonScreen(
                  pokemon: pokemon,
                );
              },
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              placeholder: (context, url) => const CircularProgressIndicator(),
              width: 100,
              height: 100,
              fit: BoxFit.fill,
              imageUrl:
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${entry.url.replaceAll(RegExp(r'[^0-9]'),'').substring(1)}.png',
            ),
            // const SizedBox(
            //   height: 12,
            // ),
            Text(
              entry.name.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w800),
            )
          ],
        ),
      ),
    );
  }
  Future<Pokemon> getPokemon(int pokemonNumber) async {
      Pokemon pokemonApi = await PokemonRepository().getPokemon(entry.url);
      if(pokemonApi.id==0){
        Pokemon pokemonDb = await DatabaseRepository.instance.getPokemon(pokemonNumber);
        return pokemonDb;
      }
      else{
        await DatabaseRepository.instance.insertPokemon(pokemon: pokemonApi);
        return await DatabaseRepository.instance.getPokemon(pokemonApi.id);
      }
  }
}

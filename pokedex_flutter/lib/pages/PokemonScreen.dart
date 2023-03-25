import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/data/models/Pokemon.dart';
import 'package:pokedex_flutter/utils/ColorConverter.dart';
import 'package:pokedex_flutter/widgets/ProgressIndicator.dart';

import '../utils/Consts.dart';


class PokemonScreen extends StatelessWidget {
  PokemonScreen({super.key, required this.pokemon});
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [convertColor(pokemon.types[0]), Colors.black])),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 40.0,
                    ),
                  ),
                ),
                CachedNetworkImage(
                  fit: BoxFit.fill,
                  width: 200,
                  height: 200,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  imageUrl:
                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon.id}.png',
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          '#${pokemon.id}',
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        pokemon.name[0].toUpperCase() +
                            pokemon.name.substring(1),
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (var i in pokemon.types)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                  color: convertColor(i),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                i.toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),

                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.height,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${pokemon.height / 10} m',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.balance,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            '${pokemon.weight / 10} kg',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      MyProgressIndicator(
                        end: pokemon.hpStat / statDev,
                        stat: 'Hp',
                        color: Colors.green,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      MyProgressIndicator(
                        end: pokemon.attackStat / statDev,
                        stat: 'Attack',
                        color: Colors.yellow,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      MyProgressIndicator(
                        end: pokemon.defenseStat / statDev,
                        stat: "Def.",
                        color: Colors.orange,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      MyProgressIndicator(
                        end: pokemon.spAttackStat / statDev,
                        stat: "Sp.Atk.",
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      MyProgressIndicator(
                        end: pokemon.spDefStat / statDev,
                        stat: "Sp.Def.",
                        color: Colors.purple,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      MyProgressIndicator(
                        end: pokemon.speedStat / statDev,
                        stat: "Speed",
                        color: Colors.pinkAccent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

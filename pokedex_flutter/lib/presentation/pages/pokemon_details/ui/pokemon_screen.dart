import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../domain/pokemon_repository.dart';
import '../../../utils/widgets/pokemon_details.dart';
import '../bloc/pokemon_details_state.dart';
import '../bloc/pokemon_details_bloc.dart';
import '../bloc/pokemon_details_event.dart';


class PokemonScreen extends StatelessWidget {
  final int id;

  const PokemonScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonDetailsBloc(GetIt.I.get<PokemonRepository>())
        ..add(
          PokemonDetailsRequest(id: id),
        ),
      child: BlocBuilder<PokemonDetailsBloc, PokemonDetailsState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: state.pokemon != null
                  ? PokemonDetails(state.pokemon!)
                  : const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
/*
PokemonDetails(Pokemon(
id: 0,
height: 0,
name: "Connection Error",
hpStat: 0,
attackStat: 0,
defenseStat: 0,
spAttackStat: 0,
spDefStat: 0,
speedStat: 0,
weight: 0,
types: ['error']));*/

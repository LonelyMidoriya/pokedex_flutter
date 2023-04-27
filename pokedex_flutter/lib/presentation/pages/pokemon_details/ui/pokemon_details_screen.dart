import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../domain/repository/pokemon_repository.dart';
import '../../../widgets/pokemon_details.dart';
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

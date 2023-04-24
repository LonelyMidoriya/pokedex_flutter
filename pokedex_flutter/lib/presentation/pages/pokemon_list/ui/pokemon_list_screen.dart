import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:number_paginator/number_paginator.dart';
import '../../../../domain/pokemon_repository.dart';
import '../../../utils/widgets/grid_item.dart';
import '../bloc/pokemon_list_bloc.dart';
import '../bloc/pokemon_list_event.dart';
import '../bloc/pokemon_list_state.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({Key? key}) : super(key: key);

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonBloc(GetIt.I.get<PokemonRepository>())
        ..add(
          PokemonInitialEvent(
            page: _currentPage,
          ),
        ),
      child: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: Row(
              children: [
                const SizedBox(
                  width: 100,
                ),
                Expanded(
                  child: NumberPaginator(
                    config: const NumberPaginatorUIConfig(
                        mode: ContentDisplayMode.dropdown),
                    numberPages: state.pagesNumber,
                    onPageChange: (int index) {
                      setState(() {
                        _currentPage = index;
                      });
                      BlocProvider.of<PokemonBloc>(context).add(
                        PokemonLoadingEvent(page: _currentPage),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 100,
                ),
              ],
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  state.pokemonEntries.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8),
                            itemCount: state.pokemonEntries.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () =>
                                    BlocProvider.of<PokemonBloc>(context).add(
                                  NavigateToChosenPokemonEvent(
                                    context: context,
                                    id: state.pokemonEntries[index].id,
                                  ),
                                ),
                                child: GridItem(state.pokemonEntries[index]),
                              );
                            },
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
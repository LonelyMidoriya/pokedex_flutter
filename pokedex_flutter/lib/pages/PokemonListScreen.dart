import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex_flutter/data/PokemonRepository.dart';

import '../data/DataBase.dart';
import '../data/models/PokemonEntry.dart';
import '../utils/Consts.dart';
import '../widgets/GridItem.dart';



class PokemonListScreen extends StatefulWidget {

  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {

  final PagingController<int, PokemonEntry> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    initDb();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    final newItems = await PokemonRepository().getPokemonList(pageKey);
    try {
      if(newItems.isNotEmpty){
        for (var element in newItems) {
          await DatabaseRepository.instance.insertPokemonList(pokemon: element);
        }
      }
       List<PokemonEntry> pokemons = await DatabaseRepository.instance.getPokemonList(pageSize, pageSize*pageKey);

      final isLastPage = pokemons.length < pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(pokemons);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(pokemons, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => Future.sync(
              () => _pagingController.refresh(),
            ),
            child: PagedGridView<int, PokemonEntry>(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              showNewPageErrorIndicatorAsGridChild: false,
              showNewPageProgressIndicatorAsGridChild: false,
              pagingController: _pagingController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
              builderDelegate: PagedChildBuilderDelegate<PokemonEntry>(
                  newPageErrorIndicatorBuilder: (_) => TextButton(
                        onPressed: () => Future.sync(
                          () => _pagingController.refresh(),
                        ),
                        child: const Text('Refresh'),
                      ),
                  animateTransitions: true,
                  itemBuilder: (context, item, index) => GridItem(item)),
            ),
          ),
        ),
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void initDb() async {
    await DatabaseRepository.instance.database;
  }
}



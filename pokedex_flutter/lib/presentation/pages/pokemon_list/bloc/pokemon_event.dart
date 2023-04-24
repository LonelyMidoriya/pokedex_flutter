import 'package:flutter/cupertino.dart';

abstract class PokemonEvent {}

class PokemonPageLoadSuccessEvent extends PokemonEvent {}

class PokemonLoadingEvent extends PokemonEvent {
  final int page;

  PokemonLoadingEvent({required this.page});
}

class PokemonInitialEvent extends PokemonEvent {
  final int page;

  PokemonInitialEvent({required this.page});
}

class NavigateToChosenPokemonEvent extends PokemonEvent {
  int id;
  BuildContext context;

  NavigateToChosenPokemonEvent({
    required this.context,
    required this.id,
  });
}

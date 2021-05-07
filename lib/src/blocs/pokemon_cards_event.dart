part of 'pokemon_cards_bloc.dart';

abstract class PokemonCardsEvent extends Equatable {
  const PokemonCardsEvent();

  @override
  List<Object> get props => [];
}

class PokemonCardsFetched extends PokemonCardsEvent {}

class PokemonCardsSearched extends PokemonCardsEvent {
  final String name;
  const PokemonCardsSearched({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

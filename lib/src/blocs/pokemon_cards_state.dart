part of 'pokemon_cards_bloc.dart';

abstract class PokemonCardsState extends Equatable {
  const PokemonCardsState();

  @override
  List<Object> get props => [];
}

class PokemonCardsInitial extends PokemonCardsState {}

class PokemonCardsLoadInProgress extends PokemonCardsState {}

class PokemonCardsEmptyLoadSuccess extends PokemonCardsState {}

class PokemonCardsLoadSuccess extends PokemonCardsState {
  final List<PokemonCard> cards;

  const PokemonCardsLoadSuccess({
    required this.cards,
  });

  @override
  List<Object> get props => [cards];
}

class PokemonCardsLoadFailure extends PokemonCardsState {}

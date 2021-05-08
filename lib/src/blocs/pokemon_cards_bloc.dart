import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_tcg_app/src/models/models.dart';
import 'package:pokemon_tcg_app/src/repositories/pokemon_tcg_repository.dart';

part 'pokemon_cards_event.dart';
part 'pokemon_cards_state.dart';

class PokemonCardsBloc extends Bloc<PokemonCardsEvent, PokemonCardsState> {
  final PokemonTcgRepository pokemonTcgRepository;

  PokemonCardsBloc({
    required this.pokemonTcgRepository,
  }) : super(PokemonCardsInitial());

  @override
  Stream<PokemonCardsState> mapEventToState(
    PokemonCardsEvent event,
  ) async* {
    if (event is PokemonCardsFetched) {
      yield PokemonCardsLoadInProgress();
      try {
        final cards = await pokemonTcgRepository.fetchPokemonTcgCards();

        if (cards.isEmpty) {
          yield PokemonCardsEmptyLoadSuccess();
          return;
        }

        yield PokemonCardsLoadSuccess(cards: cards);
      } catch (_) {
        yield PokemonCardsLoadFailure();
      }
    } else if (event is PokemonCardsSearched) {
      yield PokemonCardsLoadInProgress();
      try {
        if (event.name.isEmpty) {
          add(PokemonCardsFetched());
          return;
        }

        final cards = await pokemonTcgRepository.fetchPokemonTcgCardsByName(
          name: event.name,
        );

        if (cards.isEmpty) {
          yield PokemonCardsEmptyLoadSuccess();
          return;
        }

        yield PokemonCardsLoadSuccess(cards: cards);
      } catch (_) {
        yield PokemonCardsLoadFailure();
      }
    }
  }
}

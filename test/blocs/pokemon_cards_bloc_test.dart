import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_tcg_app/src/blocs/pokemon_cards_bloc.dart';
import 'package:pokemon_tcg_app/src/models/models.dart';
import 'package:pokemon_tcg_app/src/repositories/pokemon_tcg_repository.dart';
import 'package:test/test.dart';

import '../helpers/helpers.dart';

void main() {
  group('PokemonCardsBloc', () {
    final cards = <PokemonCard>[createPokemonCard()];
    blocTest(
      'emits [] when nothing is added',
      build: () => PokemonCardsBloc(
        pokemonTcgRepository: PokemonTcgRepository(),
      ),
      expect: () => [],
    );

    blocTest(
      'emits [PokemonCardsLoadInProgress, PokemonCardsLoadSuccess] when PokemonCardsFetched is added',
      build: () {
        final pokemonTcgRepository = MockPokemonTcgRepository();
        when(() => pokemonTcgRepository.fetchPokemonTcgCards()).thenAnswer(
          (_) async => cards,
        );

        return PokemonCardsBloc(
          pokemonTcgRepository: pokemonTcgRepository,
        );
      },
      act: (PokemonCardsBloc bloc) => bloc.add(PokemonCardsFetched()),
      expect: () => [
        PokemonCardsLoadInProgress(),
        PokemonCardsLoadSuccess(cards: cards),
      ],
    );

    blocTest(
      'emits [PokemonCardsLoadInProgress, PokemonCardsEmptyLoadSuccess] when PokemonCardsFetched is added',
      build: () {
        final pokemonTcgRepository = MockPokemonTcgRepository();
        when(() => pokemonTcgRepository.fetchPokemonTcgCards()).thenAnswer(
          (_) async => <PokemonCard>[],
        );

        return PokemonCardsBloc(
          pokemonTcgRepository: pokemonTcgRepository,
        );
      },
      act: (PokemonCardsBloc bloc) => bloc.add(PokemonCardsFetched()),
      expect: () => [
        PokemonCardsLoadInProgress(),
        PokemonCardsEmptyLoadSuccess(),
      ],
    );
  });
}

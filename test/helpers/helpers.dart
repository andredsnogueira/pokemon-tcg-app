import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_tcg_app/src/blocs/pokemon_cards_bloc.dart';
import 'package:pokemon_tcg_app/src/models/models.dart';
import 'package:pokemon_tcg_app/src/models/pokemon_card.dart';
import 'package:pokemon_tcg_app/src/repositories/pokemon_tcg_repository.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockPokemonTcgRepository extends Mock implements PokemonTcgRepository {}

class MockPokemonCardsBloc
    extends MockBloc<PokemonCardsEvent, PokemonCardsState>
    implements PokemonCardsBloc {}

class RouteFake extends Fake implements Route {}

PokemonCard createPokemonCard() {
  return PokemonCard(
    id: 'id',
    name: 'name',
    supertype: 'supertype',
    subtypes: ['subtype1', 'subtype2'],
    hp: 'hp',
    types: ['type1', 'type2'],
    evolvesFrom: 'evolvesFrom',
    abilities: <Ability>[
      Ability(
        name: 'An ability',
        text: 'A very strong ability',
        type: 'The best ability type',
      ),
    ],
    attacks: <Attack>[
      Attack(
        convertedEnergyCost: 1,
        cost: ['10'],
        damage: '100',
        name: 'Bubble beam',
        text: 'A strong Bubble beam',
      )
    ],
    level: 'level',
    image: CardImage(
      small: 'https://images.pokemontcg.io/ecard2/H1.png',
      large: 'https://images.pokemontcg.io/ecard2/H1_hires.png',
    ),
  );
}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    PokemonCardsBloc? pokemonCardsBloc,
    NavigatorObserver? navigatorObservers,
  }) {
    return pumpWidget(
      BlocProvider(
        create: (_) => pokemonCardsBloc ?? MockPokemonCardsBloc(),
        child: MaterialApp(
          home: widget,
          navigatorObservers: <NavigatorObserver>[
            navigatorObservers ?? MockNavigatorObserver(),
          ],
        ),
      ),
    );
  }
}

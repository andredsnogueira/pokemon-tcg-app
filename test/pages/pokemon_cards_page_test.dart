import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_tcg_app/src/blocs/pokemon_cards_bloc.dart';
import 'package:pokemon_tcg_app/src/pages/pages.dart';

import './../helpers/helpers.dart';

void main() {
  setUpAll(() {
    registerFallbackValue<PokemonCardsEvent>(
      PokemonCardsFetched(),
    );
    registerFallbackValue<PokemonCardsState>(
      PokemonCardsLoadSuccess(
        cards: [
          createPokemonCard(),
        ],
      ),
    );
    registerFallbackValue(RouteFake());
  });

  group('PokemonCardsPage', () {
    late PokemonCardsBloc pokemonCardsBloc;

    setUp(() {
      pokemonCardsBloc = MockPokemonCardsBloc();
    });

    testWidgets('renders SearchBar', (tester) async {
      final cards = [createPokemonCard()];

      when(() => pokemonCardsBloc.state).thenReturn(
        PokemonCardsLoadSuccess(cards: cards),
      );

      await tester.pumpApp(
        const PokemonCardsPage(),
        pokemonCardsBloc: pokemonCardsBloc,
      );
      expect(find.byType(SearchBar), findsOneWidget);
    });

    testWidgets(
        'renders a single pokemon card when the bloc state is PokemonCardsLoadSuccess',
        (tester) async {
      final cards = [createPokemonCard()];

      when(() => pokemonCardsBloc.state).thenReturn(
        PokemonCardsLoadSuccess(cards: cards),
      );

      await tester.pumpApp(
        const PokemonCardsPage(),
        pokemonCardsBloc: pokemonCardsBloc,
      );

      final cardFinder = find.byWidgetPredicate(
        (widget) =>
            widget is PokemonCardWidget &&
            widget.card.id == cards.first.id &&
            widget.card.name == cards.first.name,
      );

      expect(cardFinder, findsOneWidget);
    });

    testWidgets(
        'renders three pokemon card when the bloc state is PokemonCardsLoadSuccess',
        (tester) async {
      final cards = [
        createPokemonCard(),
        createPokemonCard(),
        createPokemonCard(),
      ];

      when(() => pokemonCardsBloc.state).thenReturn(
        PokemonCardsLoadSuccess(cards: cards),
      );

      await tester.pumpApp(
        const PokemonCardsPage(),
        pokemonCardsBloc: pokemonCardsBloc,
      );

      final pokemonCardWidgetFinder = find.byType(PokemonCardWidget);

      expect(pokemonCardWidgetFinder, findsNWidgets(3));
    });

    testWidgets(
        "renders the text 'Something went wrong.' when the bloc state is PokemonCardsLoadFailure",
        (tester) async {
      when(() => pokemonCardsBloc.state).thenReturn(
        PokemonCardsLoadFailure(),
      );

      await tester.pumpApp(
        const PokemonCardsPage(),
        pokemonCardsBloc: pokemonCardsBloc,
      );

      final textFinder = find.text('Something went wrong.');

      expect(textFinder, findsOneWidget);
    });

    testWidgets(
        "renders a CircularProgressIndicator when the bloc state is PokemonCardsLoadInProgress",
        (tester) async {
      when(() => pokemonCardsBloc.state).thenReturn(
        PokemonCardsLoadInProgress(),
      );

      await tester.pumpApp(
        const PokemonCardsPage(),
        pokemonCardsBloc: pokemonCardsBloc,
      );

      final circularProgressIndicatorFinder = find.byType(
        CircularProgressIndicator,
      );

      expect(circularProgressIndicatorFinder, findsOneWidget);
    });

    testWidgets(
        'verify if the route is pushed onto the navigator when the PokemonCardWidget is tapped ',
        (tester) async {
      final mockNavigatorObserver = MockNavigatorObserver();
      final cards = [createPokemonCard()];

      when(() => pokemonCardsBloc.state).thenReturn(
        PokemonCardsLoadSuccess(cards: cards),
      );

      await tester.pumpApp(
        const PokemonCardsPage(),
        pokemonCardsBloc: pokemonCardsBloc,
        navigatorObservers: mockNavigatorObserver,
      );

      verify(
        () => mockNavigatorObserver.didPush(any(), any()),
      ).called(1);

      final pokemonCardWidgetFinder = find.byType(PokemonCardWidget);
      expect(pokemonCardWidgetFinder, findsOneWidget);

      await tester.tap(pokemonCardWidgetFinder);

      verify(
        () => mockNavigatorObserver.didPush(any(), any()),
      ).called(1);
    });
  });
}

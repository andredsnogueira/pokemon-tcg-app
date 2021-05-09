import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_tcg_app/src/blocs/pokemon_cards_bloc.dart';
import 'package:pokemon_tcg_app/src/pages/pages.dart';
import 'package:pokemon_tcg_app/src/repositories/pokemon_tcg_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon TCG',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => PokemonCardsBloc(
          pokemonTcgRepository: PokemonTcgRepository(),
        )..add(PokemonCardsFetched()),
        child: PokemonCardsPage(),
      ),
    );
  }
}

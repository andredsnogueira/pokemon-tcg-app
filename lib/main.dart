import 'package:flutter/material.dart';
import 'package:pokemon_tcg_app/src/pages/pages.dart';

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
      home: PokemonCardsPage(),
    );
  }
}

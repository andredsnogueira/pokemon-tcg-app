import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_tcg_app/src/models/models.dart';

List<PokemonCard> parsePokemonTcgCards(String body) {
  final parsed = jsonDecode(body)['data'].cast<Map<String, dynamic>>();

  return parsed.map<PokemonCard>((json) => PokemonCard.fromJson(json)).toList();
}

class PokemonTcgRepository {
  Future<List<PokemonCard>> fetchPokemonTcgCards() async {
    final response = await http.get(
      Uri.parse('https://api.pokemontcg.io/v2/cards'),
    );

    return compute(parsePokemonTcgCards, response.body);
  }

  Future<List<PokemonCard>> fetchPokemonTcgCardsByName({
    required String name,
  }) async {
    final response = await http.get(
      Uri.parse('https://api.pokemontcg.io/v2/cards?q=name:$name'),
    );

    return compute(parsePokemonTcgCards, response.body);
  }
}

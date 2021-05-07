import 'package:json_annotation/json_annotation.dart';
import 'package:pokemon_tcg_app/src/models/ability.dart';
import 'package:pokemon_tcg_app/src/models/attack.dart';
import 'package:pokemon_tcg_app/src/models/card_image.dart';

part 'pokemon_card.g.dart';

@JsonSerializable()
class PokemonCard {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'supertype')
  final String supertype;
  @JsonKey(name: 'subtypes')
  final List<String>? subtypes;
  @JsonKey(name: 'level')
  final String? level;
  @JsonKey(name: 'hp')
  final String? hp;
  @JsonKey(name: 'types')
  final List<String>? types;
  @JsonKey(name: 'evolvesFrom')
  final String? evolvesFrom;
  @JsonKey(name: 'abilities')
  final List<Ability>? abilities;
  @JsonKey(name: 'attacks')
  final List<Attack>? attacks;
  @JsonKey(name: 'images')
  final CardImage? image;

  const PokemonCard({
    required this.id,
    required this.name,
    required this.supertype,
    required this.subtypes,
    required this.hp,
    required this.types,
    required this.evolvesFrom,
    required this.abilities,
    required this.attacks,
    required this.level,
    required this.image,
  });

  factory PokemonCard.fromJson(Map<String, dynamic> json) =>
      _$PokemonCardFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonCardToJson(this);
}

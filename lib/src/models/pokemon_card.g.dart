// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonCard _$PokemonCardFromJson(Map<String, dynamic> json) {
  return PokemonCard(
    id: json['id'] as String,
    name: json['name'] as String,
    supertype: json['supertype'] as String,
    subtypes:
        (json['subtypes'] as List<dynamic>?)?.map((e) => e as String).toList(),
    hp: json['hp'] as String?,
    types: (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
    evolvesFrom: json['evolvesFrom'] as String?,
    abilities: (json['abilities'] as List<dynamic>?)
        ?.map((e) => Ability.fromJson(e as Map<String, dynamic>))
        .toList(),
    attacks: (json['attacks'] as List<dynamic>?)
        ?.map((e) => Attack.fromJson(e as Map<String, dynamic>))
        .toList(),
    level: json['level'] as String?,
    image: json['images'] == null
        ? null
        : CardImage.fromJson(json['images'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PokemonCardToJson(PokemonCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'supertype': instance.supertype,
      'subtypes': instance.subtypes,
      'level': instance.level,
      'hp': instance.hp,
      'types': instance.types,
      'evolvesFrom': instance.evolvesFrom,
      'abilities': instance.abilities,
      'attacks': instance.attacks,
      'images': instance.image,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ability _$AbilityFromJson(Map<String, dynamic> json) {
  return Ability(
    name: json['name'] as String,
    text: json['text'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$AbilityToJson(Ability instance) => <String, dynamic>{
      'name': instance.name,
      'text': instance.text,
      'type': instance.type,
    };

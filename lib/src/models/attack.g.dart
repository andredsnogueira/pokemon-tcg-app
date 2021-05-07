// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attack _$AttackFromJson(Map<String, dynamic> json) {
  return Attack(
    name: json['name'] as String,
    cost: (json['cost'] as List<dynamic>).map((e) => e as String).toList(),
    convertedEnergyCost: json['convertedEnergyCost'] as int,
    damage: json['damage'] as String?,
    text: json['text'] as String,
  );
}

Map<String, dynamic> _$AttackToJson(Attack instance) => <String, dynamic>{
      'name': instance.name,
      'cost': instance.cost,
      'convertedEnergyCost': instance.convertedEnergyCost,
      'damage': instance.damage,
      'text': instance.text,
    };

import 'package:json_annotation/json_annotation.dart';

part 'attack.g.dart';

@JsonSerializable()
class Attack {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'cost')
  final List<String> cost;
  @JsonKey(name: 'convertedEnergyCost')
  final int convertedEnergyCost;
  @JsonKey(name: 'damage')
  final String? damage;
  @JsonKey(name: 'text')
  final String text;

  const Attack({
    required this.name,
    required this.cost,
    required this.convertedEnergyCost,
    required this.damage,
    required this.text,
  });

  factory Attack.fromJson(Map<String, dynamic> json) => _$AttackFromJson(json);
  Map<String, dynamic> toJson() => _$AttackToJson(this);
}

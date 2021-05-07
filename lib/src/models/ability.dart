import 'package:json_annotation/json_annotation.dart';

part 'ability.g.dart';

@JsonSerializable()
class Ability {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'text')
  final String text;
  @JsonKey(name: 'type')
  final String type;

  const Ability({
    required this.name,
    required this.text,
    required this.type,
  });

  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);
  Map<String, dynamic> toJson() => _$AbilityToJson(this);
}

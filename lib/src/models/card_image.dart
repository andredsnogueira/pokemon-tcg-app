import 'package:json_annotation/json_annotation.dart';

part 'card_image.g.dart';

@JsonSerializable()
class CardImage {
  @JsonKey(name: 'small')
  final String small;
  @JsonKey(name: 'large')
  final String large;

  const CardImage({
    required this.small,
    required this.large,
  });

  factory CardImage.fromJson(Map<String, dynamic> json) =>
      _$CardImageFromJson(json);
  Map<String, dynamic> toJson() => _$CardImageToJson(this);
}

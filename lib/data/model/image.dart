import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class Image {
  @JsonKey(name: 'thumb')
  String thumb;
  @JsonKey(name: 'small')
  String small;
  @JsonKey(name: 'large')
  String large;

  Image(this.thumb, this.small, this.large);

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}

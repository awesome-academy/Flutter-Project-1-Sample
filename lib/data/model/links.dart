import 'package:json_annotation/json_annotation.dart';

part 'links.g.dart';

@JsonSerializable()
class Links {
  @JsonKey(name: 'homepage')
  List<String> homepage;

  Links(this.homepage);

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
}

import 'package:json_annotation/json_annotation.dart';

part 'ath.g.dart';
@JsonSerializable()
class Ath {
  @JsonKey(name: 'usd')
  double usd;

  Ath(this.usd);

  factory Ath.fromJson(Map<String, dynamic> json) => _$AthFromJson(json);
}

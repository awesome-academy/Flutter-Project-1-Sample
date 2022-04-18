import 'package:json_annotation/json_annotation.dart';

part 'ath_date.g.dart';

@JsonSerializable()
class AthDate {
  @JsonKey(name: 'usd')
  String usd;

  AthDate(this.usd);

  factory AthDate.fromJson(Map<String, dynamic> json) => _$AthDateFromJson(json);
}

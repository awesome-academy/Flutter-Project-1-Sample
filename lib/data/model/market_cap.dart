import 'package:json_annotation/json_annotation.dart';

part 'market_cap.g.dart';

@JsonSerializable()
class MarketCap {
  @JsonKey(name: 'usd')
  double usd;

  MarketCap(this.usd);

  factory MarketCap.fromJson(Map<String, dynamic> json) => _$MarketCapFromJson(json);
}

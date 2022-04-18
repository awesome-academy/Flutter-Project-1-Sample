import 'package:json_annotation/json_annotation.dart';

part 'current_price.g.dart';

@JsonSerializable()
class CurrentPrice {
  @JsonKey(name: 'usd')
  double usd;

  CurrentPrice(this.usd);

  factory CurrentPrice.fromJson(Map<String, dynamic> json) =>
      _$CurrentPriceFromJson(json);
}

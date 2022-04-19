import 'package:json_annotation/json_annotation.dart';

part 'invest.g.dart';

@JsonSerializable()
class Invest {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'symbol')
  String symbol;
  @JsonKey(name: 'image')
  String image;
  @JsonKey(name: 'current_price')
  double currentPrice;
  @JsonKey(name: 'amount')
  double amount;

  Invest(this.id, this.name, this.symbol, this.image, this.currentPrice , this.amount);

  factory Invest.fromJson(Map<String, dynamic> json) => _$InvestFromJson(json);

  Map<String, dynamic> toJson() => _$InvestToJson(this);
}

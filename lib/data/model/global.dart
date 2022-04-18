import 'package:json_annotation/json_annotation.dart';

part 'global.g.dart';

@JsonSerializable()
class Global {
  Global(
      this.marketCap, this.ethMarketCap, this.tradingVolume, this.topCoinName);

  @JsonKey(name: 'defi_market_cap')
  String marketCap;
  @JsonKey(name: 'eth_market_cap')
  String ethMarketCap;
  @JsonKey(name: 'trading_volume_24h')
  String tradingVolume;
  @JsonKey(name: 'top_coin_name')
  String topCoinName;

  factory Global.fromJson(Map<String, dynamic> json) => _$GlobalFromJson(json);

  Map<String, dynamic> toJson() => _$GlobalToJson(this);
}

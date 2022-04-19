import 'package:json_annotation/json_annotation.dart';
import 'package:vn_crypto/data/model/ath.dart';
import 'package:vn_crypto/data/model/ath_date.dart';
import 'package:vn_crypto/data/model/current_price.dart';
import 'package:vn_crypto/data/model/market_cap.dart';

part 'market_data.g.dart';

@JsonSerializable()
class MarketData {
  @JsonKey(name: 'current_price')
  CurrentPrice currentPrice;
  @JsonKey(name: 'ath')
  Ath ath;
  @JsonKey(name: 'ath_date')
  AthDate athDate;
  @JsonKey(name: 'market_cap')
  MarketCap marketCap;
  @JsonKey(name: 'price_change_percentage_24h')
  double priceChangePercentage24h;

  MarketData(this.currentPrice, this.ath, this.athDate, this.marketCap,
      this.priceChangePercentage24h);

  factory MarketData.fromJson(Map<String, dynamic> json) =>
      _$MarketDataFromJson(json);
}

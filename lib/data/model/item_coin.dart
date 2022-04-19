import 'package:json_annotation/json_annotation.dart';
import 'package:vn_crypto/data/model/coin_detail.dart';

part 'item_coin.g.dart';

@JsonSerializable()
class ItemCoin {
  ItemCoin(this.id, this.name, this.symbol, this.curerentPrice, this.marketCap,
      this.rank, this.changePercent, this.image);

  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'symbol')
  String symbol;
  @JsonKey(name: 'current_price')
  double curerentPrice;
  @JsonKey(name: 'market_cap')
  double marketCap;
  @JsonKey(name: 'market_cap_rank')
  int rank;
  @JsonKey(name: 'price_change_percentage_24h')
  double changePercent;
  @JsonKey(name: 'image')
  String image;
  bool isFollowing = false;

  factory ItemCoin.fromJson(Map<String, dynamic> json) =>
      _$ItemCoinFromJson(json);

  factory ItemCoin.fromCoinDetails(CoinDetails coin) =>
      ItemCoin(
          coin.id,
          coin.name,
          coin.symbol,
          coin.marketData.currentPrice.usd,
          coin.marketData.marketCap.usd,
          coin.marketCapRank,
          coin.marketData.priceChangePercentage24h,
          coin.image.large);

  Map<String, dynamic> toJson() => _$ItemCoinToJson(this);
}

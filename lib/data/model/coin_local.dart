import 'package:json_annotation/json_annotation.dart';
import 'package:vn_crypto/data/model/coin_detail.dart';
import 'package:vn_crypto/data/model/item_coin.dart';

part 'coin_local.g.dart';

@JsonSerializable()
class CoinLocal {
  @JsonKey(name: "id")
  final String coinId;
  @JsonKey(name: "image")
  final String image;

  CoinLocal(this.coinId, this.image);

  factory CoinLocal.fromItemCoin(ItemCoin coin) =>
      CoinLocal(coin.id, coin.image);

  factory CoinLocal.fromCoinDetails(CoinDetails coin) =>
      CoinLocal(coin.id, coin.image.large);

  factory CoinLocal.fromJson(Map<String, dynamic> json) =>
      _$CoinLocalFromJson(json);

  Map<String, dynamic> toJson() => _$CoinLocalToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'item_trending_coin.g.dart';

@JsonSerializable()
class ItemTrendingCoin {
  ItemTrendingCoin(
      this.id, this.name, this.symbol, this.rank, this.thumb, this.score);

  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'symbol')
  String symbol;
  @JsonKey(name: 'market_cap_rank')
  int rank;
  @JsonKey(name: 'thumb')
  String thumb;
  @JsonKey(name: 'score')
  int score;

  factory ItemTrendingCoin.fromJson(Map<String, dynamic> json) =>
      _$ItemTrendingCoinFromJson(json);

  Map<String, dynamic> toJson() => _$ItemTrendingCoinToJson(this);
}

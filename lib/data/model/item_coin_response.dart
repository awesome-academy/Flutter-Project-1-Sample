import 'package:json_annotation/json_annotation.dart';

import 'item_trending_coin.dart';

part 'item_coin_response.g.dart';

@JsonSerializable()
class ItemCoinResponse {
  ItemCoinResponse(this.coin);

  @JsonKey(name: 'item')
  ItemTrendingCoin coin;

  factory ItemCoinResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemCoinResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemCoinResponseToJson(this);
}

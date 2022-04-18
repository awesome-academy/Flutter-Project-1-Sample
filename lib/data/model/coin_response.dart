import 'package:json_annotation/json_annotation.dart';

import 'item_coin_response.dart';

part 'coin_response.g.dart';

@JsonSerializable()
class CoinResponse {
  CoinResponse(this.coinResponses);

  @JsonKey(name: 'coins')
  List<ItemCoinResponse> coinResponses;

  factory CoinResponse.fromJson(Map<String, dynamic> json) =>
      _$CoinResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CoinResponseToJson(this);
}

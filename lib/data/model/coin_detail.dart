import 'package:json_annotation/json_annotation.dart';
import 'package:vn_crypto/data/model/image.dart';
import 'package:vn_crypto/data/model/links.dart';
import 'package:vn_crypto/data/model/market_data.dart';

part 'coin_detail.g.dart';

@JsonSerializable()
class CoinDetails {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'symbol')
  String symbol;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'links')
  Links links;
  @JsonKey(name: 'image')
  Image image;
  @JsonKey(name: 'market_data')
  MarketData marketData;
  @JsonKey(name: 'market_cap_rank')
  int marketCapRank;
  bool isFollowing = false;

  CoinDetails(this.id, this.symbol, this.name, this.links, this.image, this.marketData,
      this.marketCapRank);

  factory CoinDetails.fromJson(Map<String, dynamic> json) => _$CoinDetailsFromJson(json);
}

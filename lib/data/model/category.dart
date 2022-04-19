import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  Category(
      this.name, this.marketCap, this.marketCapChange, this.volume, this.coins);

  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'market_cap')
  double marketCap;
  @JsonKey(name: 'market_cap_change_24h')
  double marketCapChange;
  @JsonKey(name: 'volume_24h')
  double volume;
  @JsonKey(name: 'top_3_coins')
  List<String> coins;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

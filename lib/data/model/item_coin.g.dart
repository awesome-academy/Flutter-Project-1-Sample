// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_coin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemCoin _$ItemCoinFromJson(Map<String, dynamic> json) => ItemCoin(
      json['id'] as String,
      json['name'] as String,
      json['symbol'] as String,
      (json['current_price'] as num).toDouble(),
      (json['market_cap'] as num).toDouble(),
      json['market_cap_rank'] as int,
      (json['price_change_percentage_24h'] as num).toDouble(),
      json['image'] as String,
    )..isFollowing = json['isFollowing'] ?? false;

Map<String, dynamic> _$ItemCoinToJson(ItemCoin instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
      'current_price': instance.curerentPrice,
      'market_cap': instance.marketCap,
      'market_cap_rank': instance.rank,
      'price_change_percentage_24h': instance.changePercent,
      'image': instance.image,
      'isFollowing': instance.isFollowing,
    };

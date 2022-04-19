// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_trending_coin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemTrendingCoin _$ItemTrendingCoinFromJson(Map<String, dynamic> json) =>
    ItemTrendingCoin(
      json['id'] as String,
      json['name'] as String,
      json['symbol'] as String,
      json['market_cap_rank'] as int,
      json['thumb'] as String,
      json['score'] as int,
    );

Map<String, dynamic> _$ItemTrendingCoinToJson(ItemTrendingCoin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
      'market_cap_rank': instance.rank,
      'thumb': instance.thumb,
      'score': instance.score,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinDetails _$CoinDetailsFromJson(Map<String, dynamic> json) => CoinDetails(
      json['id'] as String,
      json['symbol'] as String,
      json['name'] as String,
      Links.fromJson(json['links'] as Map<String, dynamic>),
      Image.fromJson(json['image'] as Map<String, dynamic>),
      MarketData.fromJson(json['market_data'] as Map<String, dynamic>),
      json['market_cap_rank'] as int,
    )..isFollowing = json['isFollowing'] ?? false;

Map<String, dynamic> _$CoinDetailsToJson(CoinDetails instance) => <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'links': instance.links,
      'image': instance.image,
      'market_data': instance.marketData,
      'market_cap_rank': instance.marketCapRank,
      'isFollowing': instance.isFollowing,
    };

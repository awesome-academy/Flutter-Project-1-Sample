// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Global _$GlobalFromJson(Map<String, dynamic> json) => Global(
      json['defi_market_cap'] as String,
      json['eth_market_cap'] as String,
      json['trading_volume_24h'] as String,
      json['top_coin_name'] as String,
    );

Map<String, dynamic> _$GlobalToJson(Global instance) => <String, dynamic>{
      'defi_market_cap': instance.marketCap,
      'eth_market_cap': instance.ethMarketCap,
      'trading_volume_24h': instance.tradingVolume,
      'top_coin_name': instance.topCoinName,
    };

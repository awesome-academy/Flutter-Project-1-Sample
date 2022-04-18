// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketData _$MarketDataFromJson(Map<String, dynamic> json) => MarketData(
      CurrentPrice.fromJson(json['current_price'] as Map<String, dynamic>),
      Ath.fromJson(json['ath'] as Map<String, dynamic>),
      AthDate.fromJson(json['ath_date'] as Map<String, dynamic>),
      MarketCap.fromJson(json['market_cap'] as Map<String, dynamic>),
      (json['price_change_percentage_24h'] as num).toDouble(),
    );

Map<String, dynamic> _$MarketDataToJson(MarketData instance) =>
    <String, dynamic>{
      'current_price': instance.currentPrice,
      'ath': instance.ath,
      'ath_date': instance.athDate,
      'market_cap': instance.marketCap,
      'price_change_percentage_24h': instance.priceChangePercentage24h,
    };

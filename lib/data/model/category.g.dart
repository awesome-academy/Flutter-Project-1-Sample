// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      json['name'] as String,
      (json['market_cap'] as num).toDouble(),
      (json['market_cap_change_24h'] as num).toDouble(),
      (json['volume_24h'] as num).toDouble(),
      (json['top_3_coins'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'name': instance.name,
      'market_cap': instance.marketCap,
      'market_cap_change_24h': instance.marketCapChange,
      'volume_24h': instance.volume,
      'top_3_coins': instance.coins,
    };

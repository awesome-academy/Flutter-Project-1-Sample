// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invest _$InvestFromJson(Map<String, dynamic> json) => Invest(
      json['id'] as String,
      json['name'] as String,
      json['symbol'] as String,
      json['image'] as String,
      (json['current_price'] as num).toDouble(),
      (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$InvestToJson(Invest instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
      'image': instance.image,
      'current_price': instance.currentPrice,
      'amount': instance.amount,
    };

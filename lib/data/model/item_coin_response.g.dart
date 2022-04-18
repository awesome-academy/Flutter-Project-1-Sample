// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_coin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemCoinResponse _$ItemCoinResponseFromJson(Map<String, dynamic> json) =>
    ItemCoinResponse(
      ItemTrendingCoin.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemCoinResponseToJson(ItemCoinResponse instance) =>
    <String, dynamic>{
      'item': instance.coin,
    };

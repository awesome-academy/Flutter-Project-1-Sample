// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinResponse _$CoinResponseFromJson(Map<String, dynamic> json) => CoinResponse(
      (json['coins'] as List<dynamic>)
          .map((e) => ItemCoinResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CoinResponseToJson(CoinResponse instance) =>
    <String, dynamic>{
      'coins': instance.coinResponses,
    };

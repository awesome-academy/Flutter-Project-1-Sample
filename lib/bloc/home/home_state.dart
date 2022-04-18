import 'package:equatable/equatable.dart';
import 'package:vn_crypto/data/model/category.dart';
import 'package:vn_crypto/data/model/global.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/model/item_trending_coin.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}

class HomeStateInitialized extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoadSuccess extends HomeState {
  final List<ItemCoin> coins;
  final List<ItemTrendingCoin> trendingCoins;
  final List<Category> categories;
  final Global global;

  HomeLoadSuccess(
      {required this.coins,
      required this.trendingCoins,
      required this.categories,
      required this.global});

  @override
  List<Object> get props => [coins, trendingCoins, categories, global];
}

class HomeLoadFailed extends HomeState {
  final dynamic error;

  HomeLoadFailed(this.error);

  @override
  List<Object> get props => [error];
}

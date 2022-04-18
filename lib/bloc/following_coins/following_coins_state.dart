import 'package:equatable/equatable.dart';
import 'package:vn_crypto/data/model/item_coin.dart';

abstract class FollowingCoinsState extends Equatable {
  @override
  List<Object> get props => [];
}

class FollowingCoinsStateInitialized extends FollowingCoinsState {}

class FollowingCoinsLoading extends FollowingCoinsState {}

class FollowingCoinsLoadSuccess extends FollowingCoinsState {
  final List<ItemCoin> coins;

  FollowingCoinsLoadSuccess({required this.coins});

  @override
  List<Object> get props => [coins];
}

class FollowingCoinsLoadFailed extends FollowingCoinsState {
  final dynamic error;

  FollowingCoinsLoadFailed(this.error);

  @override
  List<Object> get props => [error];
}

class UnFollowingCoinState extends FollowingCoinsState {
  final List<ItemCoin> coins;

  UnFollowingCoinState({required this.coins});

  @override
  List<Object> get props => [coins];
}

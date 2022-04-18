import 'package:equatable/equatable.dart';
import 'package:vn_crypto/data/model/coin_local.dart';
import 'package:vn_crypto/data/model/item_coin.dart';

abstract class FollowingCoinsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FollowingCoinsLoaded extends FollowingCoinsEvent {}

class FollowingCoin extends FollowingCoinsEvent {
  final CoinLocal coin;

  FollowingCoin(this.coin);
}

class UnFollowingCoin extends FollowingCoinsEvent {
  final List<ItemCoin> coins;
  final int position;

  UnFollowingCoin(this.position, this.coins);
}

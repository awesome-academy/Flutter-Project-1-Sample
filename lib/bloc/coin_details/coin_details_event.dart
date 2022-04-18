import 'package:equatable/equatable.dart';
import 'package:vn_crypto/data/model/coin_local.dart';

abstract class CoinDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CoinDetailsLoaded extends CoinDetailsEvent {
  final String coinId;

  CoinDetailsLoaded(this.coinId);
}

class FollowingCoin extends CoinDetailsEvent {
  final CoinLocal coin;

  FollowingCoin(this.coin);
}

class UnFollowingCoin extends CoinDetailsEvent {
  final String coinId;

  UnFollowingCoin(this.coinId);
}

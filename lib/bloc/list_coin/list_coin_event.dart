import 'package:equatable/equatable.dart';
import 'package:vn_crypto/data/model/coin_local.dart';

abstract class ListCoinEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ListCoinLoaded extends ListCoinEvent {}

class FollowingCoin extends ListCoinEvent {
  final CoinLocal coin;

  FollowingCoin(this.coin);
}

class UnFollowingCoin extends ListCoinEvent {
  final String coinId;

  UnFollowingCoin(this.coinId);
}

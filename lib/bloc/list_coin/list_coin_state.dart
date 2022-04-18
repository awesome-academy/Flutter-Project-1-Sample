import 'package:equatable/equatable.dart';
import 'package:vn_crypto/data/model/item_coin.dart';

abstract class ListCoinState extends Equatable {
  @override
  List<Object> get props => [];
}

class ListCoinStateInitialized extends ListCoinState {}

class ListCoinLoading extends ListCoinState {}

class ListCoinLoadSuccess extends ListCoinState {
  final List<ItemCoin> coins;

  ListCoinLoadSuccess({required this.coins});

  @override
  List<Object> get props => [coins];
}

class ListCoinLoadFailed extends ListCoinState {
  final dynamic error;

  ListCoinLoadFailed(this.error);

  @override
  List<Object> get props => [error];
}

import 'package:equatable/equatable.dart';
import 'package:interactive_chart/interactive_chart.dart';
import 'package:vn_crypto/data/model/coin_detail.dart';

abstract class CoinDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

class CoinDetailsStateInitialized extends CoinDetailsState {}

class CoinDetailsLoading extends CoinDetailsState {}

class CoinDetailsLoadSuccess extends CoinDetailsState {
  final CoinDetails coin;
  final List<CandleData> candleDatas;
  CoinDetailsLoadSuccess({required this.coin, required this.candleDatas});

  @override
  List<Object> get props => [coin, candleDatas];
}

class CoinDetailsLoadFailed extends CoinDetailsState {
  final dynamic error;

  CoinDetailsLoadFailed(this.error);

  @override
  List<Object> get props => [error];
}

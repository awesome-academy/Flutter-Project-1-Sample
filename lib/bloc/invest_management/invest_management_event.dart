import 'package:equatable/equatable.dart';
import 'package:vn_crypto/data/model/invest.dart';

abstract class InvestManagementEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InvestManagementLoaded extends InvestManagementEvent {}

class InvestManagementSaveCoin extends InvestManagementEvent {
  final Invest invest;

  InvestManagementSaveCoin(this.invest);
}

class InvestManagementUpdateCoin extends InvestManagementEvent {
  final Invest invest;

  InvestManagementUpdateCoin(this.invest);
}

class InvestManagementDeleteCoin extends InvestManagementEvent {
  final Invest invest;

  InvestManagementDeleteCoin(this.invest);
}

class InvestManagementCoinMarketLoaded extends InvestManagementEvent {
  final String currency;

  InvestManagementCoinMarketLoaded(this.currency);
}

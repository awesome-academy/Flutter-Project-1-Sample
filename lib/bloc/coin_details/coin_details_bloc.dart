import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_chart/interactive_chart.dart';
import 'package:vn_crypto/bloc/coin_details/coin_details_event.dart';
import 'package:vn_crypto/bloc/coin_details/coin_details_state.dart';
import 'package:vn_crypto/data/model/coin_detail.dart';
import 'package:vn_crypto/data/model/coin_local.dart';
import 'package:vn_crypto/data/repository/coins_repository.dart';
import 'package:vn_crypto/data/repository/follow_repository.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class CoinDetailsBloc extends Bloc<CoinDetailsEvent, CoinDetailsState> {
  final CoinRepository coinRepository;
  final FollowRepository followRepository;

  CoinDetailsBloc({required this.coinRepository, required this.followRepository})
      : super(CoinDetailsStateInitialized()) {
    on<CoinDetailsLoaded>((event, emit) => _onGetCoin(event, emit));
    on<FollowingCoin>((event, _) => _onFollowingCoin(event));
    on<UnFollowingCoin>((event, _) => _onUnFollowingCoin(event));
  }

  void _onGetCoin(var event, var emit) async {
    String coinId = (event as CoinDetailsLoaded).coinId;
    emit(CoinDetailsLoading());
    CoinDetails coin = await coinRepository.getCoin(coinId);
    List<CandleData> candleDatas =
        await coinRepository.getCoinOhlc(coinId, AppStrings.textCurrency, Constant.defaultDays);
    List<CoinLocal> followingCoins = await followRepository.getFollowingCoins();
    for (var followingCoin in followingCoins) {
      if (followingCoin.coinId == coin.id) coin.isFollowing = true;
    }
    if (coin == null) {
      emit(CoinDetailsLoadFailed(AppStrings.errorLoadDataFailed));
    } else {
      emit(CoinDetailsLoadSuccess(coin: coin, candleDatas: candleDatas));
    }
  }

  void _onFollowingCoin(FollowingCoin event) {
    followRepository.addFollowing(event.coin);
  }

  void _onUnFollowingCoin(UnFollowingCoin event) {
    followRepository.deleteFollowing(event.coinId);
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/bloc/following_coins/following_coins_event.dart';
import 'package:vn_crypto/bloc/following_coins/following_coins_state.dart';
import 'package:vn_crypto/data/model/coin_local.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/repository/coins_repository.dart';
import 'package:vn_crypto/data/repository/follow_repository.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class FollowingCoinsBloc
    extends Bloc<FollowingCoinsEvent, FollowingCoinsState> {
  final CoinRepository coinRepository;
  final FollowRepository followRepository;

  FollowingCoinsBloc(
      {required this.coinRepository, required this.followRepository})
      : super(FollowingCoinsStateInitialized()) {
    on<FollowingCoinsLoaded>((event, emit) => _onGetCoins(emit));
    on<UnFollowingCoin>((event, emit) => _onUnFollowingCoin(event, emit));
  }

  void _onGetCoins(var emit) async {
    emit(FollowingCoinsLoading());
    List<CoinLocal> followingCoins = await followRepository.getFollowingCoins();
    List<ItemCoin> coins = [];
    for (var followingCoin in followingCoins) {
      coins.add(ItemCoin.fromCoinDetails(
          await coinRepository.getCoin(followingCoin.coinId))
        ..isFollowing = true);
    }

    if (coins.isEmpty) {
      emit(FollowingCoinsLoadFailed(AppStrings.errorLoadDataFailed));
    } else {
      emit(FollowingCoinsLoadSuccess(
          coins: coins..sort((a, b) => a.rank.compareTo(b.rank))));
    }
  }

  void _onUnFollowingCoin(UnFollowingCoin event, var emit) async {
    emit(UnFollowingCoinState(coins: event.coins));
    int result =
        await followRepository.deleteFollowing(event.coins[event.position].id);
    if (result > 0) {
      event.coins.removeAt(event.position);
      if (event.coins.isEmpty) {
        emit(FollowingCoinsLoadFailed(AppStrings.errorLoadDataFailed));
      } else {
        emit(FollowingCoinsLoadSuccess(
            coins: event.coins..sort((a, b) => a.rank.compareTo(b.rank))));
      }
    }
  }
}

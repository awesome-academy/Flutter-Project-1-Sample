import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/bloc/list_coin/list_coin_event.dart';
import 'package:vn_crypto/bloc/list_coin/list_coin_state.dart';
import 'package:vn_crypto/data/model/coin_local.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/repository/coins_repository.dart';
import 'package:vn_crypto/data/repository/follow_repository.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class ListCoinBloc extends Bloc<ListCoinEvent, ListCoinState> {
  final CoinRepository listCoinRepository;
  final FollowRepository followRepository;

  ListCoinBloc(
      {required this.listCoinRepository, required this.followRepository})
      : super(ListCoinStateInitialized()) {
    on<ListCoinLoaded>((event, emit) => _onGetCoins(emit));
    on<FollowingCoin>((event, _) => _onFollowingCoin(event));
    on<UnFollowingCoin>((event, _) => _onUnFollowingCoin(event));
  }

  void _onGetCoins(var emit) async {
    emit(ListCoinLoading());
    List<CoinLocal> followingCoins = await followRepository.getFollowingCoins();
    List<ItemCoin> coins =
    await listCoinRepository.getCoins(AppStrings.textCurrency);

    var followingCoinIds = followingCoins.map((coin) => coin.coinId);

    if (followingCoins.isNotEmpty) {
      coins.forEach((coin) {
        if (followingCoinIds.contains(coin.id)) {
          coin.isFollowing = true;
        }
      });
    }

    if (coins.isEmpty) {
      emit(ListCoinLoadFailed(AppStrings.errorLoadDataFailed));
    } else {
      emit(ListCoinLoadSuccess(coins: coins));
    }
  }

  void _onFollowingCoin(FollowingCoin event) {
    followRepository.addFollowing(event.coin);
  }

  void _onUnFollowingCoin(UnFollowingCoin event) {
    followRepository.deleteFollowing(event.coinId);
  }
}

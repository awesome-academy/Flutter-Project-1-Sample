import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/bloc/home/home_event.dart';
import 'package:vn_crypto/bloc/home/home_state.dart';
import 'package:vn_crypto/data/model/category.dart';
import 'package:vn_crypto/data/model/global.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/model/item_trending_coin.dart';
import 'package:vn_crypto/data/repository/categories_repository.dart';
import 'package:vn_crypto/data/repository/coins_repository.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CoinRepository listCoinRepository;
  final CategoryRepository categoryRepository;
  String currency = "usd";

  HomeBloc({required this.categoryRepository, required this.listCoinRepository})
      : super(HomeStateInitialized()) {
    on<HomeLoaded>((_, emit) => _onGetHomeData(emit));
  }

  void _onGetHomeData(Emitter<HomeState> emit) async {
    emit(HomeLoading());
    List<ItemCoin> coins = await listCoinRepository.getCoins(currency);
    List<ItemTrendingCoin> trendingCoins = await listCoinRepository.getTrendingCoins();
    List<Category> categories = await categoryRepository.getCategories();
    Global global = await listCoinRepository.getGlobalInfo();
    if (coins.isEmpty) {
      emit(HomeLoadFailed(AppStrings.errorLoadDataFailed));
    } else {
      emit(HomeLoadSuccess(
          coins: coins, trendingCoins: trendingCoins, categories: categories, global: global));
    }
  }
}

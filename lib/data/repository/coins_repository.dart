import 'package:interactive_chart/interactive_chart.dart';
import 'package:vn_crypto/data/model/coin_detail.dart';
import 'package:vn_crypto/data/model/global.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/model/item_trending_coin.dart';
import 'package:vn_crypto/data/service/api.dart';

class CoinRepository {
  final Api api;

  CoinRepository({required this.api});

  Future<List<ItemCoin>> getCoins(String currency) => api.getCoins(currency);

  Future<List<ItemTrendingCoin>> getTrendingCoins() => api.getTrendingCoins();

  Future<Global> getGlobalInfo() => api.getGlobalInfo();

  Future<CoinDetails> getCoin(String coinId) => api.getCoin(coinId);

  Future<List<CandleData>> getCoinOhlc(
          String coinId, String currency, int days) =>
      api.getCoinOhlc(coinId, currency, days);
}

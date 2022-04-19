import 'package:vn_crypto/data/database/database.dart';
import 'package:vn_crypto/data/model/coin_local.dart';
import 'package:vn_crypto/di/dependency_injection.dart';

class FollowRepository {
  DatabaseProvider databaseProvider = getIt<DatabaseProvider>();

  Future<List<CoinLocal>> getFollowingCoins() => databaseProvider.getCoins();

  Future<int> addFollowing(CoinLocal coin) => databaseProvider.insertCoin(coin);

  Future<int> deleteFollowing(String coinId) =>
      databaseProvider.deleteCoin(coinId);
}

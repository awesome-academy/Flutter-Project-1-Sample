import 'package:vn_crypto/data/database/database.dart';
import 'package:vn_crypto/data/model/invest.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/service/api.dart';
import 'package:vn_crypto/di/dependency_injection.dart';

class InvestRepository {
  DatabaseProvider databaseProvider = getIt.get<DatabaseProvider>();
  final Api api;

  InvestRepository({required this.api});

  Future<List<Invest>> getAllInvests() => databaseProvider.getAllInvests();

  Future<int> saveInvest(Invest invest) => databaseProvider.insertInvest(invest);

  Future<int> deleteInvest(Invest invest) => databaseProvider.deleteInvest(invest);

  Future<void> updateInvest(Invest invest) => databaseProvider.updateInvest(invest);

  Future<List<ItemCoin>> getAllCoinMarket(String currency) => api.getCoins(currency);
}

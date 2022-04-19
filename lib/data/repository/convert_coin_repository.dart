import 'package:vn_crypto/data/service/api_service.dart';

class ConvertCoinRepository {
  final Api api;

  ConvertCoinRepository({required this.api});

  Future<List<String>> getSupportedCurrencies() => api.getSupportedCurrencies();

  Future<double> getPriceConverted(String id, String currency) =>
      api.getPriceConverted(id, currency);
}

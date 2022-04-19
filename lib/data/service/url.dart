class Url {
  static const BASE_URL = "https://api.coingecko.com/api/v3";
  static const GET_COINS_URL = "$BASE_URL/coins/markets";
  static const GET_TRENDING_URL = "$BASE_URL/search/trending";
  static const GET_CATEGORIES = "$BASE_URL/coins/categories";
  static const GET_GLOBAL_INFO = "$BASE_URL/global/decentralized_finance_defi";
  static const GET_COIN_DETAILS_URL = "$BASE_URL/coins";
  static const GET_SUPPORTED_CURRENCIES =
      "${BASE_URL}/simple/supported_vs_currencies";
  static const CONVERT_PRICE = "${BASE_URL}/simple/price";
}

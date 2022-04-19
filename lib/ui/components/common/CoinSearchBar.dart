import 'package:flutter/material.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/ui/screen/ListCoinScreen.dart';

class CoinSearch extends SearchDelegate {
  final List<ItemCoin> listCoin;

  CoinSearch({required this.listCoin}) : super();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios),
        color: Colors.black);
  }

  @override
  Widget buildResults(BuildContext context) {
    List<ItemCoin> matchQuery = [];
    for (var item in listCoin) {
      if (item.name.toLowerCase().contains(query.toLowerCase()) ||
          item.symbol.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return const ListCoinScreen().listCoin(list: matchQuery);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ItemCoin> matchQuery = [];
    for (var item in listCoin) {
      if (item.name.toLowerCase().contains(query.toLowerCase()) ||
          item.symbol.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return const ListCoinScreen().listCoin(list: matchQuery);
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/ui/components/common/price_change.dart';
import 'package:vn_crypto/ui/screen/CoinDetailsScreen.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class TopCoinItem extends StatefulWidget {
  final ItemCoin itemCoin;

  const TopCoinItem({required this.itemCoin, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TopCoinItemState(itemCoin);
}

class TopCoinItemState extends State<TopCoinItem> {
  final ItemCoin itemCoin;
  var currencyFormatter = NumberFormat.simpleCurrency();

  TopCoinItemState(this.itemCoin);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: GestureDetector(
        child: SizedBox(
          width: 128,
          height: 128,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: coinImageView()),
                      Expanded(child: rankView())
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      itemCoin.name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      currencyFormatter.format(itemCoin.curerentPrice),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 6),
                    child: PriceChange(priceChangeRate: itemCoin.changePercent),
                  )
                ],
              )),
        ),
        onTap: () {
          Navigator.pushNamed(context, CoinDetailsScreen.PAGE_ROUTE_NAME,
              arguments: itemCoin);
        },
      ),
    );
  }

  Widget rankView() {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 47,
            height: 17,
            child: DecoratedBox(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(188, 185, 185, 1),
                    borderRadius: BorderRadius.circular(3))),
          ),
          Text(
            "${AppStrings.rankCoin}${itemCoin.rank.toString()}",
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget coinImageView() {
    return Padding(
        padding: const EdgeInsets.only(left: 6, top: 12, bottom: 12),
        child: Image.network(
          itemCoin.image,
          width: 34,
          height: 34,
        ));
  }
}

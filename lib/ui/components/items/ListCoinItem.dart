import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/ui/components/common/price_change.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class ListCoinItem extends StatefulWidget {
  final ItemCoin coin;
  final Function(ItemCoin coin) onFollowingClick;

  const ListCoinItem({required this.coin, required this.onFollowingClick, Key? key})
      : super(key: key);

  @override
  State<ListCoinItem> createState() => _ListCoinItemState();
}

class _ListCoinItemState extends State<ListCoinItem> {
  late String iconFollowingString;

  @override
  Widget build(BuildContext context) {
    iconFollowingString =
        widget.coin.isFollowing ? ImageAssetString.icFollowing : ImageAssetString.icUnFollowing;
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(widget.coin.image, width: 35, height: 35),
                const SizedBox(width: 6),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleWithFollow(title: widget.coin.name),
                    const SizedBox(height: 4),
                    rankAndPriceVolatility(rank: '${widget.coin.rank}')
                  ],
                ),
                Expanded(
                    child: priceAndMarketCap(
                        price: '${widget.coin.curerentPrice}', mCap: '${widget.coin.marketCap}'))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget titleWithFollow({required String title}) {
    return Row(
      children: [
        Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
        GestureDetector(
            child: SvgPicture.asset(
              iconFollowingString,
              width: 16,
            ),
            onTap: () => setState(() {
                  widget.onFollowingClick(widget.coin);
                  iconFollowingString = widget.coin.isFollowing
                      ? ImageAssetString.icFollowing
                      : ImageAssetString.icUnFollowing;
                }))
      ],
    );
  }

  Widget rankAndPriceVolatility({required String rank}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(188, 185, 185, 1),
              borderRadius: BorderRadius.circular(3)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(6, 2, 6, 1),
            child: Text(
              rank,
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ),
        const SizedBox(width: 8),
        PriceChange(priceChangeRate: widget.coin.changePercent)
      ],
    );
  }

  Widget priceAndMarketCap({required String price, required String mCap}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: AlignmentDirectional.topEnd,
          child: Text(
            '\$$price',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: AlignmentDirectional.bottomEnd,
          child: Baseline(
            baseline: 16,
            baselineType: TextBaseline.alphabetic,
            child: Text(
              '${AppStrings.textMCap}$mCap',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        )
      ],
    );
  }
}

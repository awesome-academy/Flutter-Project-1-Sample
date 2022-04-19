import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class PriceChangeWithBorder extends StatelessWidget {
  final double priceChangeRate;

  String get priceChangeRateString {
    return priceChangeRate.toStringAsFixed(2);
  }

  const PriceChangeWithBorder({required this.priceChangeRate, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int color = AppColors.colorMountainMeadow;
    String icon = ImageAssetString.icPriceUp;

    if (priceChangeRate < 0) {
      color = AppColors.colorAmaranth;
      icon = ImageAssetString.icPriceDown;
    }

    return Container(
        decoration: BoxDecoration(
            color: Color(color), borderRadius: BorderRadius.circular(4)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: SvgPicture.asset(
              icon,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 4),
          Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 6, right: 6),
              child: Baseline(
                  baseline: 18,
                  baselineType: TextBaseline.alphabetic,
                  child: Text('$priceChangeRateString%',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 14))))
        ]));
  }
}

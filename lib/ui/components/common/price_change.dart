import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class PriceChange extends StatelessWidget {
  final double priceChangeRate;


  String get priceChangeRateString{
    return priceChangeRate.toStringAsFixed(2);
  }

  const PriceChange({required this.priceChangeRate, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int color = AppColors.colorMountainMeadow;
    String icon = ImageAssetString.icPriceUp;

    if (priceChangeRate < 0) {
      color = AppColors.colorAmaranth;
      icon = ImageAssetString.icPriceDown;
    }

    return Row(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(width: 4),
        Baseline(
          baseline: 16,
          baselineType: TextBaseline.alphabetic,
          child: Text(
            '$priceChangeRateString%',
            style: TextStyle(color: Color(color), fontSize: 14)
          ),
        )
      ],
    );
  }
}

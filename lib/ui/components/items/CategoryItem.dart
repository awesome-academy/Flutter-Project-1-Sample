import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:vn_crypto/data/model/category.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class CategoryItem extends StatefulWidget {
  final Category category;

  const CategoryItem({required this.category, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CategoryItemState(category);
}

class CategoryItemState extends State<CategoryItem> {
  final Category category;
  var currencyFormatter = NumberFormat.simpleCurrency();

  CategoryItemState(this.category);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 128,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 13, top: 12),
              child: Text(
                category.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13, top: 14),
              child: Text(
                "${AppStrings.textMarketCapFull}${currencyFormatter.format(category.marketCap)}",
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.normal),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13),
              child: Text(
                "${AppStrings.textVolume24h}${currencyFormatter.format(category.volume)}",
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.normal),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: Container(
                          child: Row(
                            children: [
                              SvgPicture.asset(ImageAssetString.icChange),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "${double.parse(category.marketCapChange.toString()).toStringAsFixed(2)}%",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 20,
                        child: ListView.builder(
                            itemCount: category.coins.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Image.network(
                                  category.coins[index],
                                  width: 25,
                                  height: 25,
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

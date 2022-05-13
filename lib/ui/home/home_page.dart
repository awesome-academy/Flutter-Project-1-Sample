import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/bloc/home/home_bloc.dart';
import 'package:vn_crypto/bloc/home/home_event.dart';
import 'package:vn_crypto/bloc/home/home_state.dart';
import 'package:vn_crypto/data/model/category.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/model/item_trending_coin.dart';
import 'package:vn_crypto/data/repository/categories_repository.dart';
import 'package:vn_crypto/data/repository/coins_repository.dart';
import 'package:vn_crypto/di/dependency_injection.dart';
import 'package:vn_crypto/ui/components/items/CategoryItem.dart';
import 'package:vn_crypto/ui/components/items/TopCoinItem.dart';
import 'package:vn_crypto/ui/components/items/TrendingCoinItem.dart';
import 'package:vn_crypto/ui/components/text/ScrollingText.dart';
import 'package:vn_crypto/ui/convertcoin/convert_coin.dart';
import 'package:vn_crypto/ui/screen/FollowingCoinsScreen.dart';
import 'package:vn_crypto/ui/screen/ListCoinScreen.dart';
import 'package:vn_crypto/ultils/Constant.dart';
import 'package:vn_crypto/ultils/StringUtils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
          listCoinRepository: getIt.get<CoinRepository>(),
          categoryRepository: getIt.get<CategoryRepository>())
        ..add(HomeLoaded()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  ImageAssetString.logoAsset,
                  width: 32,
                  height: 32,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    AppStrings.appName,
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state is HomeLoadSuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          height: 64,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  color: Color.fromRGBO(72, 145, 255, 1))),
                        ),
                        SizedBox(
                          height: 30,
                          child: ScrollingText(
                              scrollAxis: Axis.horizontal,
                              text:
                                  "${AppStrings.defiMarketCap}${StringUtils.getBillionNumber(state.global.marketCap)}  -  "
                                  "${AppStrings.ethMarketCap}${StringUtils.getBillionNumber(state.global.ethMarketCap)}  -  "
                                  "${AppStrings.tradingVolume}${StringUtils.getBillionNumber(state.global.tradingVolume)}  -  "
                                  "${AppStrings.topCoin}${state.global.topCoinName}",
                              textStyle: const TextStyle(
                                  fontSize: 16, color: Colors.white)),
                        )
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 32, left: 13, right: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                  width: 161,
                                  height: 50,
                                  child: GestureDetector(
                                    child: Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            ImageAssetString.converterAsset,
                                            width: 21,
                                            height: 21,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              AppStrings.converter,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          ConvertCoinPage.PAGE_ROUTE_NAME,
                                          arguments: state.coins);
                                    },
                                  ))
                            ],
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, FollowingCoinsScreen.PAGE_ROUTE_NAME),
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: 161,
                                  height: 50,
                                  child: Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          ImageAssetString.followingAsset,
                                          width: 30,
                                          height: 30,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            AppStrings.following,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCoinTitle(AppStrings.topCoins),
                        Padding(
                            padding: const EdgeInsets.only(top: 20, right: 15),
                            child: GestureDetector(
                              child: const Text(
                                AppStrings.seeAll,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(AppColors.colorDodgerBlue),
                                    decoration: TextDecoration.underline),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ListCoinScreen()));
                              },
                            ))
                      ],
                    ),
                    listData(state.coins, state.trendingCoins, state.categories)
                  ],
                );
              } else if (state is HomeLoading) {
                return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator());
              } else {
                return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator());
              }
            }),
          ),
        ),
      ),
    );
  }

  Widget listData(List<ItemCoin> coins, List<ItemTrendingCoin> trendingCoins,
      List<Category> categories) {
    return Padding(
        padding: const EdgeInsets.only(left: 9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 128,
              child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TopCoinItem(itemCoin: coins[index]);
                  }),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 7, top: 20),
              child: Text(
                AppStrings.trending,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 128,
              child: ListView.builder(
                  itemCount: trendingCoins.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TrendingCoinItem(
                      itemCoin: trendingCoins[index],
                    );
                  }),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 7, top: 20),
              child: Text(
                AppStrings.categories,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: SizedBox(
                height: 400,
                child: ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return CategoryItem(
                        category: categories[index],
                      );
                    }),
              ),
            ),
          ],
        ));
  }

  Widget TextCoinTitle(String coinStr) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 20),
      child: Text(
        coinStr,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

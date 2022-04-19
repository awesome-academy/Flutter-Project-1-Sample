import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_chart/interactive_chart.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/link.dart';
import 'package:vn_crypto/bloc/coin_details/coin_details_bloc.dart';
import 'package:vn_crypto/bloc/coin_details/coin_details_event.dart';
import 'package:vn_crypto/bloc/coin_details/coin_details_state.dart';
import 'package:vn_crypto/data/model/coin_detail.dart';
import 'package:vn_crypto/data/model/coin_local.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/repository/coins_repository.dart';
import 'package:vn_crypto/data/repository/follow_repository.dart';
import 'package:vn_crypto/di/dependency_injection.dart';
import 'package:vn_crypto/ui/components/common/price_change_with_border.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class CoinDetailsScreen extends StatefulWidget {
  final ItemCoin coin;
  static const String PAGE_ROUTE_NAME = "/coin_detail";

  const CoinDetailsScreen({required this.coin, Key? key}) : super(key: key);

  @override
  State<CoinDetailsScreen> createState() => _CoinDetailsScreenState();
}

class _CoinDetailsScreenState extends State<CoinDetailsScreen> {
  late Icon iconFollowing;
  var currencyFormatter = NumberFormat.simpleCurrency();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CoinDetailsBloc(
            coinRepository: getIt.get<CoinRepository>(),
            followRepository: getIt.get<FollowRepository>())
          ..add(CoinDetailsLoaded(widget.coin.id)),
        child: BlocBuilder<CoinDetailsBloc, CoinDetailsState>(
            builder: (context, state) {
          iconFollowing = widget.coin.isFollowing
              ? const Icon(Icons.star_outlined,
                  color: Color(AppColors.colorDodgerBlue))
              : const Icon(Icons.star_border, color: Colors.black);

          if (state is CoinDetailsLoadSuccess) {
            return Scaffold(
                appBar: AppBar(
                  title: titleListCoin(
                      title: state.coin.name, image: state.coin.image.large),
                  actions: [
                    IconButton(
                        onPressed: () =>
                            setState(() => _onFollowingClick(context: context)),
                        icon: iconFollowing)
                  ],
                  leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      color: Colors.black),
                ),
                body: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          coinDetailsHeader(coin: state.coin),
                          const SizedBox(height: 24),
                          SizedBox(
                              height: 400,
                              child: coinChart(candleDatas: state.candleDatas)),
                          const SizedBox(height: 60),
                          coinDetailsFooter(coin: state.coin)
                        ]))));
          } else {
            return Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.star_border),
                        color: Colors.black)
                  ],
                  leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      color: Colors.black),
                ),
                body: state is CoinDetailsLoading
                    ? const Center(child: CircularProgressIndicator())
                    : const Center(
                        child: Text(AppStrings.errorLoadDataFailed)));
          }
        }));
  }

  Widget coinDetailsHeader({required CoinDetails coin}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          coin.symbol.toUpperCase(),
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        priceWithPriceChange(
            price: coin.marketData.currentPrice.usd,
            priceChangeRate: coin.marketData.priceChangePercentage24h),
        const SizedBox(height: 8),
        athAndAthDate(
            ath: coin.marketData.ath.usd, athDate: coin.marketData.athDate.usd),
      ],
    );
  }

  Widget coinDetailsFooter({required CoinDetails coin}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(AppStrings.textStatic,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        const SizedBox(height: 16),
        currentPriceAndAth(
            context: context,
            currentPrice: coin.marketData.currentPrice.usd,
            ath: coin.marketData.ath.usd),
        const SizedBox(height: 32),
        marketCapAndUrl(
            coinMarketCap: coin.marketData.marketCap.usd,
            link: coin.links.homepage.first)
      ],
    );
  }

  Widget titleListCoin({required String title, required String image}) {
    return Center(
      child: FittedBox(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(image, width: 24, height: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 24, color: Colors.black),
              )
            ]),
      ),
    );
  }

  Widget priceWithPriceChange(
      {required double price, required double priceChangeRate}) {
    return Row(children: [
      Text(
        currencyFormatter.format(price),
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      Expanded(
          child: Container(
        alignment: Alignment.centerRight,
        child: PriceChangeWithBorder(priceChangeRate: priceChangeRate),
      ))
    ]);
  }

  Widget athAndAthDate({required double ath, required String athDate}) {
    DateTime date = DateTime.parse(athDate);
    String formattedAthDate = '${date.day}/${date.month}/${date.year}';
    return Text(
        '${AppStrings.textAth}: ${currencyFormatter.format(ath)} ($formattedAthDate)',
        style: const TextStyle(fontSize: 12));
  }

  Widget coinChart({required List<CandleData> candleDatas}) {
    if (candleDatas.isEmpty) {
      candleDatas = [
        CandleData(timestamp: 0, open: 0, close: 0, volume: 0),
        CandleData(timestamp: 0, open: 0, close: 0, volume: 0),
        CandleData(timestamp: 0, open: 0, close: 0, volume: 0)
      ];
    }
    _computeTrendLines(data: candleDatas);
    return InteractiveChart(
      candles: candleDatas,
      style: const ChartStyle(
        volumeHeightFactor: 0,
      ),
    );
  }

  Widget currentPriceAndAth(
      {required context, required double currentPrice, required double ath}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              const Text(AppStrings.textCurrentAndATH,
                  style: TextStyle(fontSize: 14)),
              Expanded(
                  child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                          '${(currentPrice / ath * 100).toStringAsFixed(2)}%')))
            ],
          ),
        ),
        const SizedBox(height: 4),
        LinearPercentIndicator(
            percent: currentPrice / ath,
            lineHeight: 10,
            progressColor: Colors.black26)
      ],
    );
  }

  Widget marketCapAndUrl(
      {required double coinMarketCap, required String link}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Padding(
                  padding:
                      const EdgeInsets.only(top: 16, right: 16, bottom: 16),
                  child: marketCap(marketCap: coinMarketCap))),
          Container(color: Colors.black38, child: const SizedBox(width: 1)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
              child: url(url: link),
            ),
          )
        ],
      ),
    );
  }

  Widget marketCap({required double marketCap}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(AppStrings.textMarketCap, style: TextStyle(fontSize: 14)),
        const SizedBox(height: 4),
        Text(currencyFormatter.format(marketCap),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
      ],
    );
  }

  Widget url({required String url}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(AppStrings.textURL, style: TextStyle(fontSize: 14)),
        const SizedBox(height: 4),
        Link(
            uri: Uri.tryParse(url),
            builder: (_, link) => GestureDetector(
                onTap: link,
                child: Text(url,
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        fontWeight: FontWeight.bold))))
      ],
    );
  }

  _computeTrendLines({required List<CandleData> data}) {
    final ma7 = CandleData.computeMA(data, 7);

    for (int i = 0; i < data.length; i++) {
      data[i].trends = [ma7[i]];
    }
  }

  _onFollowingClick({var context}) {
    if (widget.coin.isFollowing) {
      BlocProvider.of<CoinDetailsBloc>(context)
          .add(UnFollowingCoin(widget.coin.id));
      widget.coin.isFollowing = false;
    } else {
      BlocProvider.of<CoinDetailsBloc>(context)
          .add(FollowingCoin(CoinLocal.fromItemCoin(widget.coin)));
      widget.coin.isFollowing = true;
    }
  }
}

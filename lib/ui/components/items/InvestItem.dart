import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vn_crypto/bloc/coin_details/coin_details_bloc.dart';
import 'package:vn_crypto/bloc/coin_details/coin_details_event.dart';
import 'package:vn_crypto/bloc/coin_details/coin_details_state.dart';
import 'package:vn_crypto/data/model/coin_detail.dart';
import 'package:vn_crypto/data/model/invest.dart';
import 'package:vn_crypto/data/repository/coins_repository.dart';
import 'package:vn_crypto/data/repository/follow_repository.dart';
import 'package:vn_crypto/di/dependency_injection.dart';
import 'package:vn_crypto/ui/components/common/price_change.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class InvestItem extends StatefulWidget {
  final Invest invest;
  final int index;
  final Function callback;

  const InvestItem({Key? key, required this.invest, required this.index, required this.callback})
      : super(key: key);

  @override
  _InvestItemState createState() => _InvestItemState();
}

class _InvestItemState extends State<InvestItem> {
  double marketPrice = 0.0;
  double priceChangePercent = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CoinDetailsBloc(
          coinRepository: getIt.get<CoinRepository>(),
          followRepository: getIt.get<FollowRepository>())
        ..add(CoinDetailsLoaded(widget.invest.id)),
      child: BlocBuilder<CoinDetailsBloc, CoinDetailsState>(
        builder: (context, state) {
          if (state is CoinDetailsLoadSuccess) {
            CoinDetails coinDetails = state.coin;
            marketPrice = coinDetails.marketData.currentPrice.usd;
            priceChangePercent =
                (marketPrice - widget.invest.currentPrice) / widget.invest.currentPrice;
            widget.callback(
                marketPrice * widget.invest.amount,
                widget.invest.currentPrice * widget.invest.amount,
                coinDetails.marketData.priceChangePercentage24h);
          }
          return Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.2))),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [investInfoView(), investPriceView()],
            ),
          );
        },
      ),
    );
  }

  Widget investInfoView() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
          child: Image.network(
            widget.invest.image,
            width: 35,
            height: 35,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.invest.name,
                style: const TextStyle(fontSize: 14),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Row(
                  children: [
                    indexView(),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        widget.invest.symbol.toUpperCase(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget indexView() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 25,
          height: 17,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(188, 185, 185, 1),
                  borderRadius: BorderRadius.circular(3))),
        ),
        Text(
          widget.index.toString(),
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
        )
      ],
    );
  }

  Widget investPriceView() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              NumberFormat.simpleCurrency().format(marketPrice),
              style: const TextStyle(fontSize: 14),
            ),
            PriceChange(priceChangeRate: priceChangePercent * 100)
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                NumberFormat.simpleCurrency()
                    .format(widget.invest.currentPrice * widget.invest.amount),
                style: const TextStyle(fontSize: 14),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text("${widget.invest.amount}${widget.invest.symbol.toUpperCase()}",
                    style: const TextStyle(fontSize: 14)),
              )
            ],
          ),
        )
      ],
    );
  }
}

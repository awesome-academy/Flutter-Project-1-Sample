import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/bloc/convert_coin/convert_coin_bloc.dart';
import 'package:vn_crypto/bloc/convert_coin/convert_coin_event.dart';
import 'package:vn_crypto/bloc/convert_coin/convert_coin_state.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/model/symbol.dart';
import 'package:vn_crypto/data/repository/convert_coin_repository.dart';
import 'package:vn_crypto/di/dependency_injection.dart';
import 'package:vn_crypto/ui/convertcoin/dialog_widget.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class ConvertCoinPage extends StatefulWidget {
  final List<ItemCoin> coins;
  static const String PAGE_ROUTE_NAME = "/convert_coin";

  const ConvertCoinPage({Key? key, required this.coins}) : super(key: key);

  @override
  _ConvertCoinPageState createState() => _ConvertCoinPageState(coins: coins);
}

class _ConvertCoinPageState extends State<ConvertCoinPage> {
  final List<ItemCoin> coins;
  ItemCoin? coin;
  String convertedSymbol = AppStrings.ETH;
  int currentIndex1 = 0;
  int currentIndex2 = 1;
  String? image;
  String numberBeforeConvert = "0.0";

  _ConvertCoinPageState({required this.coins});

  @override
  void initState() {
    super.initState();
    coin = coins[0];
    for (ItemCoin coin in coins) {
      if (coin.symbol == convertedSymbol) {
        image = coin.image;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConvertCoinBloc(
          convertCoinRepository: getIt.get<ConvertCoinRepository>()),
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: const Text(AppStrings.converter,
                textDirection: TextDirection.ltr,
                style: TextStyle(color: Colors.black, fontSize: 24)),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child: GestureDetector(
                child: BlocBuilder<ConvertCoinBloc, ConvertCoinState>(
                  builder: (context, state) {
                    if (state is ChangeColorSuccess) {
                      return Container(
                          color: (state.data as List<Color>)[1],
                          child: originalCurrencyView(context));
                    }
                    return Container(
                        color: BlocProvider.of<ConvertCoinBloc>(context)
                            .originalCoinColor,
                        child: originalCurrencyView(context));
                  },
                ),
                onTap: () {
                  BlocProvider.of<ConvertCoinBloc>(context).add(
                      ChangeColorOfCoinField(
                          Colors.white, AppColors.colorMystic));
                },
              ),
            ),
            GestureDetector(
              child: BlocBuilder<ConvertCoinBloc, ConvertCoinState>(
                builder: (context, state) {
                  if (state is ChangeColorSuccess) {
                    return Container(
                        color: (state.data as List<Color>).first,
                        child: convertedCurrencyView(context));
                  }
                  return Container(
                      color: BlocProvider.of<ConvertCoinBloc>(context)
                          .convertedCoinColor,
                      child: convertedCurrencyView(context));
                },
              ),
              onTap: () {
                BlocProvider.of<ConvertCoinBloc>(context).add(
                    ChangeColorOfCoinField(
                        AppColors.colorMystic, Colors.white));
              },
            )
          ],
        ),
      ),
    );
  }

  void showCurrenciesDialog(List<Symbol> symbolList, bool isFromServer) {
    var dialogWidget = DialogWidget(
      symbols: symbolList,
      isFromServer: isFromServer,
      currentIndex2: currentIndex2,
    );
    dialogWidget.callback = callBackUpdateCurrency;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: dialogWidget);
        });
  }

  void callBackUpdateCurrency(
      String currency, bool isOriginalCoin, int currentIndex2) {
    setState(() {
      if (isOriginalCoin) {
        for (int i = 0; i < coins.length; i++) {
          if (currency == coins[i].symbol) {
            currentIndex1 = i;
            coin = coins[i];
            break;
          }
        }
      } else {
        convertedSymbol = currency;
        this.currentIndex2 = currentIndex2;
        for (ItemCoin coin in coins) {
          if (coin.symbol == convertedSymbol) {
            image = coin.image;
          }
        }
      }
    });
  }

  Widget originalCurrencyView(BuildContext blocContext) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 27, top: 16, bottom: 16),
          child: Row(
            children: [
              Image.network(
                coin!.image,
                width: 35,
                height: 35,
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    coin!.symbol.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  List<Symbol> symbols = [];
                  for (int i = 0; i < coins.length; i++) {
                    symbols.add(Symbol(
                        coins[i].symbol, i == currentIndex1 ? true : false));
                  }
                  showCurrenciesDialog(symbols, false);
                  BlocProvider.of<ConvertCoinBloc>(blocContext).add(
                      ChangeColorOfCoinField(
                          Colors.white, AppColors.colorMystic));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Image.asset(
                  ImageAssetString.icDrop,
                  width: 9,
                  height: 7,
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Column(
              children: [
                SizedBox(
                  width: 50,
                  height: 30,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      if (text.isNotEmpty) {
                        numberBeforeConvert = text.contains(AppStrings.COMMA)
                            ? text.replaceAll(AppStrings.COMMA, AppStrings.DOT)
                            : text;
                        BlocProvider.of<ConvertCoinBloc>(blocContext)
                            .add(ConvertCoinLoaded(coin!.id, convertedSymbol));
                      }
                    },
                  ),
                ),
                Text(
                  coin!.symbol.toUpperCase(),
                  style: const TextStyle(fontSize: 14),
                )
              ],
            ))
      ],
    );
  }

  Widget convertedCurrencyView(BuildContext blocContext) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 27, top: 16, bottom: 16),
          child: Row(
            children: [
              Image.network(
                image!,
                width: 35,
                height: 35,
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    convertedSymbol.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  showCurrenciesDialog([], true);
                  BlocProvider.of<ConvertCoinBloc>(blocContext).add(
                      ChangeColorOfCoinField(
                          AppColors.colorMystic, Colors.white));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Image.asset(
                  ImageAssetString.icDrop,
                  width: 9,
                  height: 7,
                ),
              )
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Column(
              children: [
                BlocBuilder<ConvertCoinBloc, ConvertCoinState>(
                  builder: (context, state) {
                    if (state is ConvertCoinSuccess) {
                      double price = state.data as double;
                      double newPrice =
                          double.parse(numberBeforeConvert) * price;
                      return Text(
                        newPrice.toStringAsFixed(2),
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      );
                    } else if (state is ConvertCoinLoading) {
                      return const CircularProgressIndicator();
                    } else {
                      return Text(
                        numberBeforeConvert,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      );
                    }
                  },
                ),
                Text(
                  convertedSymbol.toUpperCase(),
                  style: const TextStyle(fontSize: 14),
                )
              ],
            ))
      ],
    );
  }
}

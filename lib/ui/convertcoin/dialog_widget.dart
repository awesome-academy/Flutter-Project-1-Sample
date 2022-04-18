import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/bloc/convert_coin/convert_coin_bloc.dart';
import 'package:vn_crypto/bloc/convert_coin/convert_coin_event.dart';
import 'package:vn_crypto/bloc/convert_coin/convert_coin_state.dart';
import 'package:vn_crypto/data/model/symbol.dart';
import 'package:vn_crypto/data/repository/convert_coin_repository.dart';
import 'package:vn_crypto/di/dependency_injection.dart';
import 'package:vn_crypto/ui/components/common/CoinSearchBarSymbol.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class DialogWidget extends StatefulWidget {
  final List<Symbol> symbols;
  Function? callback;
  final bool isFromServer;
  final int currentIndex2;

  DialogWidget(
      {Key? key, required this.symbols, required this.isFromServer, required this.currentIndex2})
      : super(key: key);

  @override
  _DialogWidgetState createState() =>
      _DialogWidgetState(symbols, callback, isFromServer, currentIndex2);
}

class _DialogWidgetState extends State<DialogWidget> {
  final List<Symbol> symbols;
  final Function? callback;
  String currentOriginalCoin = "";
  final bool isFromServer;
  final int currentIndex2;

  _DialogWidgetState(this.symbols, this.callback, this.isFromServer, this.currentIndex2);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: !isFromServer
          ? dialogLayout(symbols, callback, currentOriginalCoin, !isFromServer)
          : BlocProvider(
              create: (context) =>
                  ConvertCoinBloc(convertCoinRepository: getIt.get<ConvertCoinRepository>())
                    ..add(SupportedCoinsLoaded()),
              child: BlocBuilder<ConvertCoinBloc, ConvertCoinState>(
                builder: (context, state) {
                  if (state is ConvertCoinSuccess) {
                    List<Symbol> symbols = [];
                    List<String> supportedSymbols = state.data as List<String>;
                    for (int i = 0; i < supportedSymbols.length; i++) {
                      symbols.add(Symbol(supportedSymbols[i], i == currentIndex2 ? true : false));
                    }
                    return dialogLayout(symbols, callback, currentOriginalCoin, !isFromServer);
                  } else {
                    return Container(
                        alignment: Alignment.center, child: const CircularProgressIndicator());
                  }
                },
              ),
            ),
    );
  }

  Widget dialogLayout(
      List<Symbol> symbols, Function? callback, String currentOriginalCoin, bool isOriginalCoin) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 15, right: 10),
                child: Icon(Icons.search, size: 24),
              ),
              SearchBarSymbol(),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: ListView.builder(
                itemCount: symbols.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.2))),
                    ),
                    child: GestureDetector(
                      child: Container(
                        color: symbols[index].isSelected ? Colors.black12 : Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 23, top: 20, bottom: 20),
                              child: Text(
                                symbols[index].name.toUpperCase(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Visibility(
                                  visible: symbols[index].isSelected,
                                  child: Image.asset(
                                    ImageAssetString.icChecked,
                                    width: 22,
                                    height: 22,
                                  )),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          widget.callback!(symbols[index].name, isOriginalCoin, index);
                        });
                        Navigator.of(context).pop(true);
                      },
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}

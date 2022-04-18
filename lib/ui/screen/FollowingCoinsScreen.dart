import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/bloc/following_coins/following_coins_bloc.dart';
import 'package:vn_crypto/bloc/following_coins/following_coins_event.dart';
import 'package:vn_crypto/bloc/following_coins/following_coins_state.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/repository/coins_repository.dart';
import 'package:vn_crypto/data/repository/follow_repository.dart';
import 'package:vn_crypto/di/dependency_injection.dart';
import 'package:vn_crypto/ui/components/common/CoinSearchBar.dart';
import 'package:vn_crypto/ui/components/items/ListCoinItem.dart';
import 'package:vn_crypto/ui/screen/CoinDetailsScreen.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class FollowingCoinsScreen extends StatelessWidget {
  static const String PAGE_ROUTE_NAME = "/following_coin";

  const FollowingCoinsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var followingCoinBloc = FollowingCoinsBloc(
      coinRepository: getIt.get<CoinRepository>(),
      followRepository: getIt.get<FollowRepository>(),
    )..add(FollowingCoinsLoaded());
    return BlocProvider(
        create: (_) => followingCoinBloc,
        child: BlocBuilder<FollowingCoinsBloc, FollowingCoinsState>(
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                    title: const Text(AppStrings.titleFollowingCoin,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(color: Colors.black)),
                    actions: [
                      IconButton(
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: CoinSearch(
                                  listCoin: state is FollowingCoinsLoadSuccess
                                      ? state.coins
                                      : []));
                        },
                        icon: const Icon(Icons.search),
                        color: Colors.black,
                      )
                    ],
                    leading: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_rounded),
                        color: Colors.black)),
                body: buildBody(state: state));
          },
        ));
  }

  Widget buildBody({var state}) {
    if (state is FollowingCoinsLoadSuccess || state is UnFollowingCoinState) {
      return listCoin(list: state.coins);
    } else if (state is FollowingCoinsLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return const Center(child: Text(AppStrings.textEmptyList));
    }
  }

  Widget listCoin({required List<ItemCoin> list}) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              Navigator.pushNamed(context, CoinDetailsScreen.PAGE_ROUTE_NAME,
                  arguments: list[index]);
            },
            child: ListCoinItem(
                coin: list[index],
                onFollowingClick: (coin) => _onFollowingClick(
                    context: context, position: index, listCoins: list)));
      },
      itemCount: list.length,
      separatorBuilder: (_, context) => const Divider(
        height: 1,
      ),
    );
  }

  void _onFollowingClick(
      {var context, required int position, required List<ItemCoin> listCoins}) {
    BlocProvider.of<FollowingCoinsBloc>(context)
        .add(UnFollowingCoin(position, listCoins));
  }
}

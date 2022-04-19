import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/bloc/list_coin/list_coin_bloc.dart';
import 'package:vn_crypto/bloc/list_coin/list_coin_event.dart';
import 'package:vn_crypto/bloc/list_coin/list_coin_state.dart';
import 'package:vn_crypto/data/model/coin_local.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/repository/coins_repository.dart';
import 'package:vn_crypto/data/repository/follow_repository.dart';
import 'package:vn_crypto/di/dependency_injection.dart';
import 'package:vn_crypto/ui/components/common/CoinSearchBar.dart';
import 'package:vn_crypto/ui/components/items/ListCoinItem.dart';
import 'package:vn_crypto/ui/screen/CoinDetailsScreen.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class ListCoinScreen extends StatelessWidget {
  const ListCoinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listCoinBloc = ListCoinBloc(
        listCoinRepository: getIt.get<CoinRepository>(),
        followRepository: getIt.get<FollowRepository>())
      ..add(ListCoinLoaded());
    return BlocProvider(
        create: (_) => listCoinBloc,
        child: RefreshIndicator(
          onRefresh: () async {
            listCoinBloc.add(ListCoinLoaded());
          },
          child: BlocBuilder<ListCoinBloc, ListCoinState>(
            builder: (context, state) {
              return Scaffold(
                  appBar: AppBar(
                      title: const Text(AppStrings.titleListTopCoin,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(color: Colors.black)),
                      actions: [
                        IconButton(
                          onPressed: () {
                            showSearch(
                                context: context,
                                delegate: CoinSearch(
                                    listCoin: state is ListCoinLoadSuccess
                                        ? state.coins
                                        : []));
                          },
                          icon: const Icon(Icons.search),
                          color: Colors.black,
                        )
                      ]),
                  body: buildBody(state: state));
            },
          ),
        ));
  }

  Widget buildBody({var state}) {
    if (state is ListCoinLoadSuccess) {
      return listCoin(list: state.coins);
    } else if (state is ListCoinLoading) {
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
                onFollowingClick: (coin) =>
                    _onFollowingClick(context: context, coin: coin)));
      },
      itemCount: list.length,
      separatorBuilder: (_, context) => const Divider(
        height: 1,
      ),
    );
  }

  _onFollowingClick({var context, required ItemCoin coin}) {
    if (coin.isFollowing) {
      BlocProvider.of<ListCoinBloc>(context).add(UnFollowingCoin(coin.id));
      coin.isFollowing = false;
    } else {
      BlocProvider.of<ListCoinBloc>(context)
          .add(FollowingCoin(CoinLocal.fromItemCoin(coin)));
      coin.isFollowing = true;
    }
  }
}

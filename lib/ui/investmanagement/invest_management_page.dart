import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vn_crypto/bloc/invest_management/invest_management_bloc.dart';
import 'package:vn_crypto/bloc/invest_management/invest_management_event.dart';
import 'package:vn_crypto/bloc/invest_management/invest_management_state.dart';
import 'package:vn_crypto/data/model/invest.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/data/repository/InvestRepository.dart';
import 'package:vn_crypto/di/dependency_injection.dart';
import 'package:vn_crypto/ui/components/common/price_change.dart';
import 'package:vn_crypto/ui/components/items/InvestItem.dart';
import 'package:vn_crypto/ui/investmanagement/add_invest_page.dart';
import 'package:vn_crypto/ui/investmanagement/select_invest_dialog.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class InvestManagementScreen extends StatefulWidget {
  const InvestManagementScreen({Key? key}) : super(key: key);

  @override
  _InvestManagementScreenState createState() => _InvestManagementScreenState();
}

class _InvestManagementScreenState extends State<InvestManagementScreen> {
  double currentBalance = 0.0;
  double originalBalance = 0.0;
  int investAmount = 0;
  int countInvest = 0;
  List<double> priceChangePercents = [];
  List<double> originalPrices = [];
  bool isResetState = false;
  int colorPriceChange = AppColors.colorMountainMeadow;
  NumberFormat currencyFormatter = NumberFormat.simpleCurrency();
  late List<Invest> invests = [];

  double balanceChange24hPercent = 0.0;
  double totalProfitLoss = 0.0;
  double totalProfitLossPercent = 0.00;
  InvestManagementBloc? investManagementBloc;

  void initBloc() async {
    investManagementBloc =
        InvestManagementBloc(investRepository: getIt.get<InvestRepository>())
          ..add(InvestManagementLoaded());
  }

  @override
  void initState() {
    super.initState();
    initBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => investManagementBloc!,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              AppStrings.investManagement,
            ),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, top: 10),
                  child: Text(
                    AppStrings.currentBalance,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 4),
                  child: Text(
                    currencyFormatter.format(currentBalance),
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                balanceChange24h(),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 28),
                  child: SizedBox(
                      height: 72,
                      width: double.infinity,
                      child: totalProfitView()),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16, top: 40),
                  child: Text(
                    AppStrings.yourAssets,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                BlocBuilder<InvestManagementBloc, InvestManagementState>(
                  builder: (context, state) {
                    if (state is InvestManagementSuccess) {
                      invests = state.data;
                      investAmount = invests.length;
                      return listInvestView();
                    } else if (state is InvestManagementSaveSuccess) {
                      if (!isResetState) {
                        invests.add(state.data as Invest);
                        investAmount = invests.length;
                        resetInfo();
                      }
                      return listInvestView();
                    } else if (state is InvestManagementUpdateSuccess) {
                      if (!isResetState) {
                        for (int i = 0; i < invests.length; i++) {
                          if (invests[i].id == (state.data as Invest).id) {
                            invests.removeAt(i);
                            invests.insert(i, state.data as Invest);
                          }
                        }
                        investAmount = invests.length;
                        resetInfo();
                      }
                      return listInvestView();
                    } else {
                      return const SizedBox(
                        height: 100,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "You don't have any invests.",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    }
                  },
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: addNewButton()),
              ],
            ),
          ),
        ));
  }

  void resetInfo() {
    countInvest = 0;
    currentBalance = 0;
    originalBalance = 0;
    originalPrices = [];
  }

  void getInfoOfInvest(
      double price, double originalPrice, double priceChange24h) {
    if (countInvest < investAmount) {
      countInvest++;
      currentBalance += price;
      originalBalance += originalPrice;
      priceChangePercents.add(priceChange24h);
      originalPrices.add(originalPrice);
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        if (countInvest == investAmount) {
          totalProfitLoss = currentBalance - originalBalance;
          totalProfitLossPercent = totalProfitLoss / originalBalance;
          for (int i = 0; i < countInvest; i++) {
            balanceChange24hPercent +=
                priceChangePercents[i] * (originalPrices[i] / originalBalance);
          }
          colorPriceChange = balanceChange24hPercent >= 0
              ? AppColors.colorMountainMeadow
              : AppColors.colorAmaranth;
          if (!isResetState) {
            setState(() {
              isResetState = true;
            });
          }
        }
      });
    }
  }

  Widget balanceChange24h() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 4),
      child: Text(
        balanceChange24hPercent >= 0
            ? "+${balanceChange24hPercent.toStringAsFixed(2)}% (24h)"
            : "${balanceChange24hPercent.toStringAsFixed(2)}% (24h)",
        style: TextStyle(
          color: Color(colorPriceChange),
          fontSize: 14,
        ),
      ),
    );
  }

  Widget listInvestView() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
          itemCount: investAmount,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return InvestItem(
              invest: invests[index],
              index: index + 1,
              callback: getInfoOfInvest,
            );
          }),
    );
  }

  Widget totalProfitView() {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(AppColors.colorWildSand))),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  AppStrings.totalProfitLoss,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.75), fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Text(
                  totalProfitLoss >= 0
                      ? "+${currencyFormatter.format(totalProfitLoss)}"
                      : currencyFormatter.format(totalProfitLoss),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              )
            ],
          ),
        ),
        Positioned(
            bottom: 4,
            right: 14,
            child: Row(
              children: [
                PriceChange(priceChangeRate: totalProfitLossPercent * 100)
              ],
            ))
      ],
    );
  }

  Widget addNewButton() {
    return GestureDetector(
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: const Color(AppColors.colorDodgerBlue),
          child: const Align(
            alignment: Alignment.center,
            child: Text(
              AppStrings.addNewAsset,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: SelectInvestDialog(callback: onSelectedInvest));
            });
      },
    );
  }

  void onSelectedInvest(ItemCoin itemCoin) {
    Navigator.pushNamed(context, AddInvestPage.PAGE_ROUTE_NAME,
        arguments: [itemCoin, onAddNewInvest]);
  }

  void onAddNewInvest(Invest invest) {
    bool isExist = false;
    isResetState = false;
    if (invests.isNotEmpty) {
      for (Invest investItem in invests) {
        if (investItem.id == invest.id) {
          double newAmount = investItem.amount + invest.amount;
          double averagePrice = (investItem.amount * investItem.currentPrice +
                  invest.amount * invest.currentPrice) /
              newAmount;
          investManagementBloc?.add(InvestManagementUpdateCoin(Invest(
              investItem.id,
              investItem.name,
              investItem.symbol,
              investItem.image,
              averagePrice,
              newAmount)));
          isExist = true;
          break;
        }
      }
    }
    if (!isExist) {
      investManagementBloc?.add(InvestManagementSaveCoin(invest));
    }
  }
}

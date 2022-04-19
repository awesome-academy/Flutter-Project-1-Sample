import 'package:flutter/material.dart';
import 'package:vn_crypto/data/model/invest.dart';
import 'package:vn_crypto/data/model/item_coin.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class AddInvestPage extends StatefulWidget {
  final ItemCoin itemCoin;
  final Function addInvestCallback;
  static const String PAGE_ROUTE_NAME = "/add_invest";

  const AddInvestPage(
      {Key? key, required this.itemCoin, required this.addInvestCallback})
      : super(key: key);

  @override
  _AddInvestPageState createState() => _AddInvestPageState();
}

class _AddInvestPageState extends State<AddInvestPage> {
  double amount = 0.0;
  String convertCurrency = "USD";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          title: Row(
            children: [
              Image.network(
                widget.itemCoin.image,
                width: 23,
                height: 23,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(widget.itemCoin.name,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(color: Colors.black)),
              ),
            ],
          ),
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
              padding: const EdgeInsets.only(top: 100, left: 30),
              child: amountOfCurrency()),
          GestureDetector(
            child: Column(
              children: [
                Image.asset(
                  ImageAssetString.icConvert,
                  width: 22,
                  height: 22,
                ),
                Text(
                  convertCurrency,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                )
              ],
            ),
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              "${widget.itemCoin.curerentPrice}\$/1${widget.itemCoin.symbol.toUpperCase()}",
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
            child: addNewButton(),
          )
        ],
      ),
    );
  }

  Widget amountOfCurrency() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 180,
          height: 100,
          child: TextFormField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "0.0",
                hintStyle: TextStyle(color: Color(AppColors.colorSilver))),
            style: const TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.bold,
                color: Color(AppColors.colorSilver)),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (text) {
              if (text.isNotEmpty) {
                amount = double.parse(text);
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            widget.itemCoin.symbol.toUpperCase(),
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
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
              AppStrings.add,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
      onTap: () {
        ItemCoin itemCoin = widget.itemCoin;
        Invest invest = Invest(itemCoin.id, itemCoin.name, itemCoin.symbol,
            itemCoin.image, itemCoin.curerentPrice, amount);
        widget.addInvestCallback(invest);
        Navigator.of(context).pop(true);
      },
    );
  }
}

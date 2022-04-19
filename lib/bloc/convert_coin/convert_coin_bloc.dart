import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/bloc/convert_coin/convert_coin_event.dart';
import 'package:vn_crypto/bloc/convert_coin/convert_coin_state.dart';
import 'package:vn_crypto/data/repository/convert_coin_repository.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class ConvertCoinBloc extends Bloc<ConvertCoinEvent, ConvertCoinState> {
  final ConvertCoinRepository convertCoinRepository;
  Color originalCoinColor = Colors.black12;
  Color convertedCoinColor = Colors.transparent;

  ConvertCoinBloc({required this.convertCoinRepository})
      : super(ConvertCoinInitialize()) {
    on<ConvertCoinLoaded>(
        (event, emit) => _onGetPriceConvertedData(event, emit));
    on<SupportedCoinsLoaded>((event, emit) => _onGetSupportedCurrenciesData());
    on<ChangeColorOfCoinField>(
        (event, emit) => _onChangeCoinFieldColor(event, emit));
  }

  void _onChangeCoinFieldColor(
      ConvertCoinEvent event, Emitter<ConvertCoinState> emitter) {
    Color originalColor = (event as ChangeColorOfCoinField).originalColor;
    Color convertedColor = event.convertedColor;
    print('state: ' + originalColor.value.toString());
    print('state: ' + convertedColor.value.toString());
    emitter(ConvertCoinSuccess(data: [originalColor , convertedColor]));
  }

  void _onGetSupportedCurrenciesData() async {
    emit(ConvertCoinLoading());
    List<String> currencies =
        await convertCoinRepository.getSupportedCurrencies();
    if (currencies.isNotEmpty) {
      emit(ConvertCoinSuccess(data: currencies));
    } else {
      emit(ConvertCoinLoadFailed(error: AppStrings.errorLoadDataFailed));
    }
  }

  void _onGetPriceConvertedData(
      ConvertCoinEvent event, Emitter<ConvertCoinState> emit) async {
    String id = (event as ConvertCoinLoaded).id;
    String currency = event.currency;
    emit(ConvertCoinLoading());
    double price = await convertCoinRepository.getPriceConverted(id, currency);
    if (price != null) {
      emit(ConvertCoinSuccess(data: price));
    } else {
      emit(ConvertCoinLoadFailed(error: AppStrings.errorConvertCoin));
    }
  }
}

import 'package:equatable/equatable.dart';

abstract class ConvertCoinState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ConvertCoinInitialize extends ConvertCoinState {}

class ConvertCoinLoading extends ConvertCoinState {}

class ConvertCoinSuccess extends ConvertCoinState {
  final dynamic data;

  ConvertCoinSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class ConvertCoinLoadFailed extends ConvertCoinState {
  final dynamic error;

  ConvertCoinLoadFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

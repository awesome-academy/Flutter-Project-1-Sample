import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();

  @override
  List<Object> get props => [];
}

class InitState extends BaseState {}

class LoadingState extends BaseState {}

class LoadedState extends BaseState {
  final dynamic data;

  const LoadedState({required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];
}

class ErrorState extends BaseState {
  final dynamic data;

  const ErrorState({required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];
}

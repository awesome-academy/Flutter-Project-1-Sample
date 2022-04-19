import 'package:equatable/equatable.dart';

abstract class InvestManagementState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InvestManagementInitialize extends InvestManagementState {}

class InvestManagementSuccess extends InvestManagementState {
  dynamic data;

  InvestManagementSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class InvestManagementSaveSuccess extends InvestManagementState {
  dynamic data;

  InvestManagementSaveSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class InvestManagementUpdateSuccess extends InvestManagementState {
  dynamic data;

  InvestManagementUpdateSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class InvestManagementLoading extends InvestManagementState {}

class InvestManagementFailed extends InvestManagementState {
  dynamic error;

  InvestManagementFailed(this.error);

  @override
  List<Object?> get props => [error];
}

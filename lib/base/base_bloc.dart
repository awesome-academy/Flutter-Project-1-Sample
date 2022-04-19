import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/base/base.dart';

abstract class BaseBloc extends Bloc<BaseEvent, BaseState>{
  BaseBloc(BaseState initialState) : super(initialState);
}

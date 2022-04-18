import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/bloc/theme/theme_event.dart';
import 'package:vn_crypto/bloc/theme/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeStateInitialized()) {
    on<ChangeTheme>((event, emit) => _onChangeTheme(event, emit));
  }

  _onChangeTheme(ChangeTheme event, var emit) {
    if (event.isDarkTheme) {
      emit(DarkThemeState());
    } else {
      emit(LightThemeState());
    }
  }
}

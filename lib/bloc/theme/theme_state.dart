import 'package:equatable/equatable.dart';

abstract class ThemeState extends Equatable {
  @override
  List<Object> get props => [];
}

class ThemeStateInitialized extends ThemeState {}

class LightThemeState extends ThemeState {}

class DarkThemeState extends ThemeState {}

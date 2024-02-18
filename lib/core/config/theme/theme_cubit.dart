import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ThemeColorCubit extends Cubit<Color> {
  ThemeColorCubit() : super(Colors.green);
  void changeThemeColor(Color color) {
    debugPrint('Theme color changed');
    emit(color);
  }
}

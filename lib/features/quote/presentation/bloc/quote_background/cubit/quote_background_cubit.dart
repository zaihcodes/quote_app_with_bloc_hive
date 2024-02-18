import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quotes_app/core/data/app_images.dart';

part 'quote_background_state.dart';

class QuoteBackgroundCubit extends Cubit<int> {
  QuoteBackgroundCubit() : super(0);

  void ChangeBackground() {
    emit(Random().nextInt(AppImages.images.length));
  }
}

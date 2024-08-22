import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_flutter/02_timer/app_config_bloc/app_config.dart';

class AppConfigBloc extends Cubit<AppConfig> {
  AppConfigBloc({required AppConfig initialState}) : super(initialState);

  /// 切换主题色
  void switchThemeColor(Color color) {
    /// 判断是否需要更新
    if (color != state.themeColor) {
      emit(state.copyWith(color: color));
    }
  }

  /// 切换语言
  void switchLocal(Locale locale) {
    if (locale != state.locale) {
      emit(state.copyWith(locale: locale));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_flutter/02_timer/app_config_bloc/app_config_bloc.dart';
import 'package:play_flutter/02_timer/home_page/home_page.dart';

import 'app_config_bloc/app_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(BlocProvider<AppConfigBloc>(
    create: (context) => AppConfigBloc(initialState: AppConfig.defaultConfig()),
    child: const StopwatchApp(),
  ));
}

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({super.key});

  final SystemUiOverlayStyle _systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppConfigBloc, AppConfig>(
      builder: (context, state) {
        return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: state.locale,
            theme: ThemeData(
              primaryColor: state.themeColor,
              appBarTheme: AppBarTheme(
                systemOverlayStyle: _systemUiOverlayStyle,
              ),
            ),
            home: const HomePage());
      },
    );
  }
}

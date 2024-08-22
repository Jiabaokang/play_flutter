import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppConfig {
  final Color themeColor;
  final Locale locale;

  const AppConfig({
    required this.themeColor,
    required this.locale,
  });

  AppConfig.defaultConfig()
      : themeColor = const Color(0xff3bbd5b),
        locale = languagesSupports.values.first;

  AppConfig copyWith({Color? color, Locale? locale}) {
    return AppConfig(
      themeColor: color ?? themeColor,
      locale: locale ?? this.locale,
    );
  }

  static Map<String, Locale> languagesSupports = {
    "简体中文": AppLocalizations.supportedLocales[1],
    "English": AppLocalizations.supportedLocales[0],
  };
}

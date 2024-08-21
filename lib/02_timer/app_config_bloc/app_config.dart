import 'package:flutter/material.dart';

class AppConfig {
  final Color themeColor;

  const AppConfig({
    required this.themeColor,
  });

  const AppConfig.defaultConfig() : themeColor = const Color(0xff3bbd5b);

  AppConfig copyWith({
    Color? color,
  }) {
    return AppConfig(themeColor: color ?? themeColor);
  }
}

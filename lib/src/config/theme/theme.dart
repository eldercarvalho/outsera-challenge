import 'package:flutter/material.dart';

import 'color_scheme.dart';
import 'text_theme.dart';

class AppTheme {
  static ThemeData dark = ThemeData.dark().copyWith(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: const Color(0xFF111418),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF111418),
      elevation: 0,
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF8D9199),
      thickness: 1,
    ),
    textTheme: textTheme,
  );
}

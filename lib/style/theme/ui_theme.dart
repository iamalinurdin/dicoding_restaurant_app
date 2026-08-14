import 'package:flutter/material.dart';
import 'package:restaurant_app/style/colors/ui_colors.dart';
import 'package:restaurant_app/style/typography/ui_text_styles.dart';

class UiTheme {
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: UiTextStyles.displayLarge,
      displayMedium: UiTextStyles.displayMedium,
      displaySmall: UiTextStyles.displaySmall,
      headlineLarge: UiTextStyles.headlineLarge,
      headlineMedium: UiTextStyles.headlineMedium,
      headlineSmall: UiTextStyles.headlineSmall,
      titleLarge: UiTextStyles.titleLarge,
      titleMedium: UiTextStyles.titleMedium,
      titleSmall: UiTextStyles.titleSmall,
      bodyLarge: UiTextStyles.bodyLargeBold,
      bodyMedium: UiTextStyles.bodyLargeMedium,
      bodySmall: UiTextStyles.bodyLargeRegular,
      labelLarge: UiTextStyles.labelLarge,
      labelMedium: UiTextStyles.labelMedium,
      labelSmall: UiTextStyles.labelSmall,
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      toolbarTextStyle: _textTheme.titleLarge,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: UiColors.blue.color,
      brightness: Brightness.light,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: UiColors.blue.color,
      brightness: Brightness.dark,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }
}

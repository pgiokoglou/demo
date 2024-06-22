import "package:demo/views/theming/main_theme_colors.dart";
import "package:flutter/material.dart";

ThemeData get mainTheme => ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: MainThemeColors.appBarBackgroundColor,
        centerTitle: false,
      ),
      buttonBarTheme: const ButtonBarThemeData(),
      scaffoldBackgroundColor: MainThemeColors.backgroundColor,
      listTileTheme: ListTileThemeData(
        leadingAndTrailingTextStyle: const TextStyle(fontSize: 35),
        titleTextStyle: TextStyle(
          color: MainThemeColors.secondaryColor,
          fontSize: 12,
        ),
        subtitleTextStyle: TextStyle(
          color: MainThemeColors.primaryColor,
          fontSize: 20.0,
        ),
      ),
    );

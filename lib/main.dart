import "package:flutter/material.dart";
import "package:expense_trakker/expenses.dart";

var kColorsScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 33, 79, 121));
var kdarkColorsScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: const Color.fromRGBO(2, 50, 72, 1));

void main() {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      cardTheme: const CardTheme().copyWith(
          color: kdarkColorsScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 12)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kdarkColorsScheme.secondaryContainer,
              foregroundColor: kdarkColorsScheme.onSecondaryContainer)),
    ),
    theme: ThemeData().copyWith(
        colorScheme: kColorsScheme,
        appBarTheme: const AppBarTheme().copyWith(
          foregroundColor: kColorsScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
            color: kColorsScheme.primary,
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 12)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorsScheme.secondaryContainer)),
        textTheme: const TextTheme().copyWith(
            titleLarge: TextStyle(
                fontWeight: FontWeight.w500,
                color: kColorsScheme.primaryContainer,
                fontSize: 16))),
    themeMode: ThemeMode.system,
    home: const Expenses(),
  ));
}

import 'package:expense_tracker/widgets/expense_page.dart';
import 'package:flutter/material.dart';

//import 'package:flutter/services.dart';//

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 170, 225, 255));
var kDarkColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 130, 176, 255));

void main()  {
  runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark().copyWith(
            useMaterial3: true,
            colorScheme: kDarkColorScheme,
            appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kDarkColorScheme.primary,
              foregroundColor: kDarkColorScheme.onPrimary,
            ),
            cardTheme: const CardTheme()
                .copyWith(color: kDarkColorScheme.secondaryContainer),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkColorScheme.onPrimary,
                  foregroundColor: kDarkColorScheme.primary),
            ),
          ),
          theme: ThemeData().copyWith(
            useMaterial3: true,
            colorScheme: kColorScheme,
            appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorScheme.primary,
              foregroundColor: kColorScheme.onPrimary,
            ),
            cardTheme: const CardTheme()
                .copyWith(color: kColorScheme.secondaryContainer),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kColorScheme.secondaryContainer,
                  foregroundColor: kColorScheme.primary),
            ),
          ),
          themeMode: ThemeMode.system,
          home: const ExpensePage(),
        ),
      );
    }
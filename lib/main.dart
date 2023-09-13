import 'package:flutter/material.dart';


import 'package:expense_tracker/Widgets/expenses.dart';



var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 84, 15, 140));

var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 24, 30, 29));

void main() {


    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kDarkColorScheme,
          cardTheme: const CardTheme().copyWith(
            color: kDarkColorScheme.secondaryContainer.withOpacity(.7),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          ),
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkColorScheme.primaryContainer)),
          iconTheme: ThemeData()
              .iconTheme
              .copyWith(color: kDarkColorScheme.onPrimaryContainer),
          textTheme: ThemeData().textTheme.copyWith(
              titleSmall: TextStyle(
                fontWeight: FontWeight.bold,
                color: kDarkColorScheme.onPrimaryContainer,
              ),
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kDarkColorScheme.onPrimaryContainer,
                  fontSize: 16))),
      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kColorScheme.primaryContainer)),
          iconTheme: ThemeData().iconTheme.copyWith(color: kColorScheme.primary),
          textTheme: ThemeData().textTheme.copyWith(
              titleSmall: TextStyle(color: kColorScheme.primary,
                  fontWeight: FontWeight.bold,),


              titleLarge: TextStyle(
                  color: kColorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16))),
      home: const Expenses(),
    ));


}

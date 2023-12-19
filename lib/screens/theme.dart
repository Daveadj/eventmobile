import 'package:eventmobile/logging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    Log.i('Theme toggled to: $themeMode');
    notifyListeners();
  }
}

final themeProvider =
    ChangeNotifierProvider<ThemeNotifier>((ref) => ThemeNotifier());

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark(),
    useMaterial3: true,
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white, // Set label color in dark mode
      unselectedLabelColor:
          Colors.grey, // Set unselected label color in dark mode
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    useMaterial3: true,
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.black, // Set label color in light mode
      unselectedLabelColor:
          Colors.grey, // Set unselected label color in light mode
    ),
  );
}

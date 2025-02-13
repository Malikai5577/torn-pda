// Flutter imports:
import 'package:flutter/material.dart';
import 'package:torn_pda/main.dart';

// Project imports:
import 'package:torn_pda/utils/shared_prefs.dart';

enum AppTheme {
  light,
  dark,
  extraDark,
}

class ThemeProvider extends ChangeNotifier {
  Color? canvas;
  Color? secondBackground;
  Color? mainText;
  Color? buttonText;
  Color? navSelected;
  Color? cardColor;
  Color? statusBar;

  ThemeProvider() {
    _restoreSharedPreferences();
  }

  var _currentTheme = AppTheme.light;
  AppTheme get currentTheme => _currentTheme;
  set changeTheme(AppTheme themeType) {
    _currentTheme = themeType;
    _getColors();
    _saveThemeSharedPrefs();
    notifyListeners();
  }

  // COLORS ##LIGHT##
  final _canvasBackgroundLIGHT = Colors.grey[50];
  final _colorBackgroundLIGHT = Colors.grey[200];
  final _colorMainTextLIGHT = Colors.black;
  final _colorButtonTextLIGHT = Colors.white;
  final _colorNavSelectedLIGHT = Colors.blueGrey[100];
  final _colorCardLIGHT = Colors.white;
  final _colorStatusBarLIGHT = Colors.blueGrey;

  // COLORS ##DARK##
  final _canvasBackgroundDARK = Colors.grey[900];
  final _colorBackgroundDARK = Colors.grey[800];
  final _colorMainTextDARK = Colors.grey[50];
  final _colorButtonTextDARK = Colors.grey[200];
  final _colorNavSelectedDARK = Colors.blueGrey[600];
  final _colorCardDARK = Colors.grey[800];
  final _colorStatusBarDARK = const Color.fromARGB(255, 37, 37, 37);

  // COLORS ##EXTRA DARK##
  final _canvasBackgroundExtraDARK = Colors.black;
  final _colorBackgroundExtraDARK = const Color(0xFF0C0C0C);
  final _colorMainTextExtraDARK = Colors.grey[50];
  final _colorButtonTextExtraDARK = Colors.grey[200];
  final _colorNavSelectedExtraDARK = Colors.blueGrey[800];
  final _colorCardExtraDARK = const Color(0xFF131313);
  final _colorStatusBarExtraDARK = const Color(0xFF0C0C0C);

  void _getColors() {
    switch (_currentTheme) {
      case AppTheme.light:
        canvas = _canvasBackgroundLIGHT;
        secondBackground = _colorBackgroundLIGHT;
        mainText = _colorMainTextLIGHT;
        buttonText = _colorButtonTextLIGHT;
        navSelected = _colorNavSelectedLIGHT;
        cardColor = _colorCardLIGHT;
        statusBar = _colorStatusBarLIGHT;
      case AppTheme.dark:
        canvas = _canvasBackgroundDARK;
        secondBackground = _colorBackgroundDARK;
        mainText = _colorMainTextDARK;
        buttonText = _colorButtonTextDARK;
        navSelected = _colorNavSelectedDARK;
        cardColor = _colorCardDARK;
        statusBar = _colorStatusBarDARK;
      case AppTheme.extraDark:
        canvas = _canvasBackgroundExtraDARK;
        secondBackground = _colorBackgroundExtraDARK;
        mainText = _colorMainTextExtraDARK;
        buttonText = _colorButtonTextExtraDARK;
        navSelected = _colorNavSelectedExtraDARK;
        cardColor = _colorCardExtraDARK;
        statusBar = _colorStatusBarExtraDARK;
    }
  }

  void _saveThemeSharedPrefs() {
    late String themeSave;
    switch (_currentTheme) {
      case AppTheme.light:
        themeSave = 'light';
      case AppTheme.dark:
        themeSave = 'dark';
      case AppTheme.extraDark:
        themeSave = 'extraDark';
    }
    Prefs().setAppTheme(themeSave);
  }

  Future<void> _restoreSharedPreferences() async {
    final String restoredTheme = await Prefs().getAppTheme();
    await analytics.setUserProperty(name: "theme", value: restoredTheme);
    switch (restoredTheme) {
      case 'light':
        _currentTheme = AppTheme.light;
      case 'dark':
        _currentTheme = AppTheme.dark;
      case 'extraDark':
        _currentTheme = AppTheme.extraDark;
    }

    _getColors();
    notifyListeners();
  }
}

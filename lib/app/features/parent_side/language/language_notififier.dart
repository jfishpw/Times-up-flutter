import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:times_up_flutter/services/shared_preferences.dart';

class LanguageNotifier extends ChangeNotifier {
  late String _selectedLanguage = '🇺🇸 English󠁢';
  late Locale _locale = const Locale('en');

  String get selectedLanguage => _selectedLanguage;
  Locale get locale => _locale;

  List<String> languages = [
    '🇺🇸 English󠁢',
    '🇫🇷 Français󠁢',
    '🇪🇸 Español',
    '🇹🇷 Turkish',
    '🇩🇪 Deutsch',
    '🇨🇳 中文',
  ];

  Future<void> initLocalization() async {
    _locale = await CacheService.getLocale();
    _setLanguageString();
    languages
      ..insert(languages.indexOf(_selectedLanguage), _selectedLanguage)
      ..removeWhere((element) => element == _selectedLanguage);
    notifyListeners();
  }

  void selectLanguage(String language) {
    languages.insert(languages.indexOf(language), _selectedLanguage);
    _selectedLanguage = language;
    languages.removeWhere((element) => element == _selectedLanguage);
    _locale = setLocale(_selectedLanguage);
    CacheService.setLocale(value: _locale);
    HapticFeedback.heavyImpact();
    notifyListeners();
  }

  void _setLanguageString() {
    switch (_locale.languageCode) {
      case 'en':
        _selectedLanguage = '🇺🇸 English󠁢';
        break;
      case 'fr':
        _selectedLanguage = '🇫🇷 Français󠁢';
        break;
      case 'es':
        _selectedLanguage = '🇪🇸 Español';
        break;
      case 'de':
        _selectedLanguage = '🇩🇪 Deutsch';
        break;
      case 'tr':
        _selectedLanguage = '🇹🇷 Turkish󠁢';
        break;
      case 'zh':
        _selectedLanguage = '🇨🇳 中文';
        break;
    }
  }

  Locale setLocale(String selectedLanguage) {
    switch (selectedLanguage) {
      case '🇫🇷 Français󠁢':
        return const Locale('fr');
      case '🇺🇸 English󠁢':
        return const Locale('en');
      case '🇪🇸 Español':
        return const Locale('es');
      case '🇹🇷 Turkish':
        return const Locale('tr');
      case '🇩🇪 Deutsch󠁢':
        return const Locale('de');
      case '🇨🇳 中文':
        return const Locale('zh');
      default:
        return const Locale('en');
    }
  }
}

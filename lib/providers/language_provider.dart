import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('ar');
  
  Locale get locale => _locale;
  
  bool get isArabic => _locale.languageCode == 'ar';
  
  LanguageProvider() {
    _loadLanguage();
  }
  
  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('languageCode') ?? 'ar';
    _locale = Locale(languageCode);
    notifyListeners();
  }
  
  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;
    
    _locale = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
    notifyListeners();
  }
  
  Future<void> toggleLanguage() async {
    final newLocale = isArabic ? const Locale('en') : const Locale('ar');
    await setLocale(newLocale);
  }
}
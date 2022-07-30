import 'package:abc_maung/lang/en_us.dart';
import 'package:abc_maung/lang/un_mm.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'dart:ui';

class LocalizationService extends Translations {
  final box = GetStorage();
  // Default locale
  late Locale locale;
  late String current;
  // static const locale = Locale('un', 'MM');

  // fallbackLocale saves the day when the locale gets in trouble
  static const fallbackLocale = Locale('un', 'MM');

  // Supported languages
  // Needs to be same order with locales
  static final langs = [
    'English',
    'မြန်မာ',
  ];

  // Supported locales
  // Needs to be same order with langs
  static const locales = [
    Locale('en', 'US'),
    Locale('un', 'MM'),
  ];

  LocalizationService(){
    current = box.read('current')?? 'မြန်မာ';
    int i = langs.indexWhere((element) => element==current);
    locale = locales[i];
  }


  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS, // lang/en_us.dart
        'un_MM': unMM, // lang/un_mm.dart
      };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    box.write('current', lang);
    current=lang;
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}
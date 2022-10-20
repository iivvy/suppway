import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suppwayy_mobile/main_repository.dart';
import 'package:suppwayy_mobile/setting/models/saved_app_settings.dart';

class SettingService extends MainRepository {
  MainRepository mainRepository = MainRepository();
  SavedAppSettings settings =
      SavedAppSettings(language: 'fr', theme: 'light', maxSavedTraces: 5);

  Future<SavedAppSettings> get getSettings async {
    await readSavedSettings();
    return settings;
  }

  Future<SavedAppSettings> initSettings() {
    return getSettings;
  }

  Future<void> readSavedSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String language = prefs.getString("language") ?? "fr";
    String theme = prefs.getString("theme") ?? "light";
    int maxSavedTraces = prefs.getInt("maxSavedTraces") ?? 5;
    settings.language = language;
    settings.theme = theme;
    settings.maxSavedTraces = maxSavedTraces;
  }

  Future<SavedAppSettings> setStringValue(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    return getSettings;
  }

  Future<SavedAppSettings> setIntegerValue(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
    return getSettings;
  }

  Future<SavedAppSettings> saveBoolValue(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
    return getSettings;
  }
}

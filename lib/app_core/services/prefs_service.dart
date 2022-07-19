// import 'dart:convert';

import 'dart:convert';

import 'package:alsurrah/app_core/domain/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static PrefsService? _instance;
  static SharedPreferences? _preferences;

  /// Keys
  static const String appLanguageKey = 'language_code';
  static const String user = 'user';
  static const String NOTIFICATION_FlAG = 'notificationFlag';
  // static const String HAS_SIGN_IN_SEEN = 'HAS_SIGN_IN_SEEN';
  static const String HAS_INTRO_SEEN = 'HAS_INTRO_SEEN';

  static Future<PrefsService?> getInstance() async {
    _instance ??= PrefsService();

    _preferences ??= await SharedPreferences.getInstance();

    return _instance;
  }

  dynamic _getFromPrefs(String key) {
    var value = _preferences!.get(key);
    // print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  // updated _saveToDisk function that handles all types
  void _saveToPrefs<T>(String key, T content) {
    // print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences!.setString(key, content);
    } else if (content is bool) {
      _preferences!.setBool(key, content);
    } else if (content is int) {
      _preferences!.setInt(key, content);
    } else if (content is double) {
      _preferences!.setDouble(key, content);
    } else if (content is List<String>) {
      _preferences!.setStringList(key, content);
    }
  }

  // remove from Prefs
  void _removeFromPrefs(String key) {
    _preferences!.remove(key);
  }

  // clear all Prefs
  void clearAllPrefs() {
    _preferences!.clear();
  }

  // getter for App language.
  String get appLanguage => _getFromPrefs(appLanguageKey) ?? 'ar';
  // setter for App language.
  set appLanguage(String value) => _saveToPrefs(appLanguageKey, value);
  /////////////////////////////////////////////////////////////////////////////////

  // /////////////////////////////////////////////////////////////////////////////////
  bool get notificationFlag => _getFromPrefs(NOTIFICATION_FlAG) ?? true;
  set notificationFlag(bool value) => _saveToPrefs(NOTIFICATION_FlAG, value);

  // getter for USER_OBJECT.
  User? get userObj {
    var userJson = _getFromPrefs(user);
    if (userJson == null) {
      return null;
    }

    return User.fromJson(json.decode(userJson));
  }

  // setter for USER_OBJECT.
  set userObj(User? userToSave) {
    _saveToPrefs(user, json.encode(userToSave?.toJson()));
  }

  // // Remove UserObj
  removeUserObj() => _removeFromPrefs(user);
  /////////////////////////////////////////////////////////////////////////////////

  // bool get hasSignInSeen => _getFromPrefs(HAS_SIGN_IN_SEEN) ?? false;
  // set hasSignInSeen(bool value) => _saveToPrefs(HAS_SIGN_IN_SEEN, value);

  bool get hasIntroSeen => _getFromPrefs(HAS_INTRO_SEEN) ?? false;
  set hasIntroSeen(bool value) => _saveToPrefs(HAS_INTRO_SEEN, value);
}

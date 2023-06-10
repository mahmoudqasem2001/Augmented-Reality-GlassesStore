// SharedPreferences store data key : value
// methods: set - get - delete

import 'package:shared_preferences/shared_preferences.dart';

class CacheData {
  static late SharedPreferences sharedPreferences; // declare

  static Future<void> cacheInitialization() async {
    sharedPreferences = await SharedPreferences.getInstance(); // assignment
  }

  //methods
  // 1.set
  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    await cacheInitialization();

    if (value is int) {
      await sharedPreferences.setInt(key, value);
      return true;
    }
    if (value is String) {
      await sharedPreferences.setString(key, value);
      return true;
    }
    if (value is bool) {
      await sharedPreferences.setBool(key, value);
      return true;
    }
    if (value is double) {
      await sharedPreferences.setDouble(key, value);
      return true;
    }
    return false;
  }

  // 2.get
  static Future<String> getData({required String key}) async {
    await cacheInitialization();

    return sharedPreferences.getString(key) ?? "";
  }

  // 3.delete
  static Future<bool> deleteItem({required String key}) async {
    await cacheInitialization();

    return sharedPreferences.remove(key);
  }

  static Future<void> clearitems() async {
    await cacheInitialization();
    sharedPreferences.clear();
  }
}

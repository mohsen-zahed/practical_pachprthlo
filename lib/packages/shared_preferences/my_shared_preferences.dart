import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static MySharedPreferences? _instance;
  MySharedPreferences._();
  static MySharedPreferences get instance {
    _instance ??= MySharedPreferences._();
    return _instance!;
  }

  Future<void> storeToSharedPreferences(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getFromSharedPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<bool> removeFromSharedPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }
}

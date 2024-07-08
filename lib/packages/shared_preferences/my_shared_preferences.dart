import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static MySharedPreferences? _instance;
  MySharedPreferences._();
  static MySharedPreferences get instance {
    _instance ??= MySharedPreferences._();
    return _instance!;
  }

  Future<void> storeToSharedPreferences(String key, String value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, value);
  }

  Future<String?> getFromSharedPreferences(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }
}

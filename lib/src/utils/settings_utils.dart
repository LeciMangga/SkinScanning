import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class SettingsUtils {
  static Future<void> remove(String key) async {
    final GetStorage box = GetStorage();
    await box.remove(key);
  }

  static Future<void> setString(String key, String? value) async {
    final GetStorage box = GetStorage();
    await box.write(key, value);
  }

  static Future<String> getString(String key) async {
    final GetStorage box = GetStorage();
    return await box.read(key) ?? '';
  }

  static Future<void> setBool(String key, bool value) async {
    final GetStorage box = GetStorage();
    await box.write(key, value);
  }

  static Future<bool> getBool(String key) async {
    final GetStorage box = GetStorage();
    return await box.read(key) ?? false;
  }

  static Future<void> setDouble(String key, double value) async {
    final GetStorage box = GetStorage();
    await box.write(key, value);
  }

  static Future<double> getDouble(String key) async {
    final GetStorage box = GetStorage();
    return await box.read(key) ?? 0;
  }
}
import 'package:shared_preferences/shared_preferences.dart';

// Define a method to save a MyObject to shared preferences
Future<void> saveObjectToPrefs(String key, String json) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, json);
}

// Define a method to retrieve a MyObject from shared preferences
Future<String> getObjectFromPrefs(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? ''; // return an empty string if value is null
}

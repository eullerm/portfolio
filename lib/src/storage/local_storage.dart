import 'package:localstorage/localstorage.dart';

final _localStorage = LocalStorage('portfolio');

// Define a method to save a MyObject to shared preferences
Future<void> saveObject(String key, String json) async {
  _localStorage.setItem(key, json);
}

Future<String> getObject(String key) async {
  await _localStorage.ready;
  final object = _localStorage.getItem(key);
  return object ?? '';
}

Future<void> clearLocalStorage() async {
  _localStorage.clear();
}

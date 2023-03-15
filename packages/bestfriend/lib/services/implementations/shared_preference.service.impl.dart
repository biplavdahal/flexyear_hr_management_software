import 'package:bestfriend/bestfriend.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceServiceImplementation implements SharedPreferenceService {
  late SharedPreferences _prefs;

  @override
  Future<void> call() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<KVData<T>> get<T>(String key) {
    T _value = _prefs.get(key) as T;
    return Future.value(KVData<T>.of(key, _value));
  }

  @override
  Future<KVData> set<T>(String key, T value) async {
    switch (T) {
      case String:
        _prefs.setString(key, value as String);
        break;
      case int:
        _prefs.setInt(key, value as int);
        break;
      case bool:
        _prefs.setBool(key, value as bool);
        break;
      case double:
        _prefs.setDouble(key, value as double);
        break;
      case List:
        _prefs.setStringList(key, value as List<String>);
        break;
      default:
        throw Exception("Could not set the type $T in shared preferences.");
    }

    return KVData.of(key, value);
  }

  @override
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }
}

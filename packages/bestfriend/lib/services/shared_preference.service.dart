import 'package:bestfriend/bestfriend.dart';

abstract class SharedPreferenceService {
  // Callable to get the shared preference file.
  Future<void> call();

  /// Sets a value in the shared preference file.
  Future<KVData> set<T>(String key, T value);

  /// Gets a value from the shared preference file.
  Future<KVData<T>> get<T>(String key);

  /// Remove a key value from the shared preference file.
  Future<void> remove(String key);
}

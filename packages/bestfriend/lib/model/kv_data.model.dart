class KVData<T> {
  final String key;
  final T value;

  KVData._({required this.key, required this.value});

  factory KVData.of(String key, T value) {
    return KVData._(key: key, value: value);
  }

  @override
  String toString() {
    return "KVData($key, $value)";
  }
}

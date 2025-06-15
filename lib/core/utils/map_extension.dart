extension MapExtension on Map<String, dynamic> {
  String? getString(String key) {
    return this[key] as String?;
  }

  int? getInt(String key) {
    return this[key] as int?;
  }

  double? getDouble(String key) {
    return this[key] as double?;
  }

  bool? getBool(String key) {
    return this[key] as bool?;
  }

  List<dynamic>? getList(String key) {
    return this[key] as List<dynamic>?;
  }

  Map<String, dynamic>? getMap(String key) {
    return this[key] as Map<String, dynamic>?;
  }

  Map<String, dynamic> removeNullValues() {
    return Map.fromEntries(entries.where((entry) => entry.value != null));
  }
}

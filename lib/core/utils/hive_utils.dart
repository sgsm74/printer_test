import 'package:hive/hive.dart';

import '../errors/exceptions.dart';

Future<void> saveListToHive<Type>(String key, dynamic list) async {
  final box = await Hive.openBox<dynamic>(key);
  await box.clear();
  await box.put(key, list);
  await box.close();
}

Future<void> saveMapDataToHive<Type>(
  String boxName,
  Map<String, Type> mapData,
) async {
  final box = await Hive.openBox<Type>(boxName);
  for (final MapEntry<String, Type> entry in mapData.entries) {
    await box.put(entry.key, entry.value);
  }
  await box.close();
}

Future<Map<Key, Value>> loadHiveKeyValuePairs<Key, Value>(
  String boxName,
) async {
  final box = await Hive.openBox<Value>(boxName);
  final keyValueMap = box.toMap().cast<Key, Value>();
  await box.close();
  return keyValueMap;
}

Future<List<Type>> loadListFromHive<Type>(String key) async {
  //("box $key opened");
  final box = await Hive.openBox<dynamic>(key);
  final keys = box.keys;
  final List<Type> list = [];
  for (var element in keys) {
    if (box.get(element).runtimeType == List) {
      List x = box.get(element) ?? [];
      list.addAll(x.cast<Type>());
    } else {
      list.add(box.get(element)!);
    }
  }
  //("box $key closed");
  await box.close();
  if (list.isEmpty) {
    throw HiveException();
  } else {
    return list;
  }
}

Future<void> saveMapToHive<Type>(String boxName, String key, Type value) async {
  final box = await Hive.openBox<Type>(boxName);
  await box.put(key, value);
  await box.close();
}

Future<Type> loadMapFromHive<Type>(String boxName, String key) async {
  final box = await Hive.openBox<Type>(boxName);
  final Type? value = box.get(key);
  await box.close();
  if (value == null) {
    throw HiveException();
  } else {
    return value;
  }
}

Future<void> saveToHive<Type>(String key, Type value) async {
  //("box $key opened");
  final box = await Hive.openBox<Type>(key);
  await box.put(key, value);
  //("box $key closed");
  await box.close();
}

Future<Type> loadFromHive<Type>(String key) async {
  //("box $key opened");
  final box = await Hive.openBox<Type>(key);
  final Type? value = box.get(key);
  await box.close();
  //("box $key closed");
  if (value == null) {
    throw HiveException();
  } else {
    return value;
  }
}

Future<void> deleteFromHive<Type>(String boxName, String key) async {
  final box = await Hive.openBox<Type>(boxName);
  await box.delete(key);
  await box.close();
}

Future<void> deleteFromDisk<Type>(List<String> boxNames) async {
  for (final boxName in boxNames) {
    if (!await Hive.boxExists(boxName)) continue;
    await Hive.deleteBoxFromDisk(boxName);
  }
}

Future<void> clearAllFromHive(String boxNames) async {
  final box = await Hive.openBox(boxNames);
  await box.clear();
  await box.close();
}

Future<void> saveToListHive<Type>(String key, Type value) async {
  //("box $key opened");
  final box = await Hive.openBox<Type>(key);
  await box.add(value);
  //("box $key closed");
  await box.close();
}

Future<void> saveUniqueItemToHive<Type>(String key, Type value) async {
  List<Type> list;
  try {
    list = await loadListFromHive<Type>(key);
  } catch (_) {
    list = [];
  }
  final box = await Hive.openBox<Type>(key);
  if (list.isEmpty || !list.contains(value)) await box.add(value);
  await box.close();
}

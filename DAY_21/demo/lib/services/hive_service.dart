import 'package:hive/hive.dart';

class HiveService {
  static const String boxName = 'demo';

  // Save a simple string to Hive local storage.
  Future<void> save(String value) async {
    final box = await Hive.openBox<String>(boxName);
    await box.put('message', value);
  }

  // Get the stored string from Hive local storage.
  Future<String> getMessage() async {
    final box = await Hive.openBox<String>(boxName);
    return box.get('message', defaultValue: 'No data saved yet')!;
  }
}

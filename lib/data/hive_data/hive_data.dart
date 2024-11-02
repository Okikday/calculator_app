import 'package:hive/hive.dart';

class HiveData {
  
  static late Box box;

  // Initialize regular Hive box
  static Future<void> initHiveData() async {
    box = await Hive.openBox("box");
  }

  Future<dynamic> getData({required String key}) async => await box.get(key);

  Future<void> setData({required String key, required dynamic value}) async => await box.put(key, value);

  Future<void> deleteData({required String key}) async => await box.delete(key);
}

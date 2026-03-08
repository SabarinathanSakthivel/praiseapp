import 'package:sqflite/sqflite.dart';
import '../../models/device_settings.dart';
import 'db_script.dart';

class SettingsDBScript {
  Future<int> insertSettings(DeviceSettings model) async {
    Database db = await DBScript.instance.database;
    var result = await db.insert(DBScript.DEVICE_SETTINGS, {
      DBScript.Settings_Key: model.key,
      DBScript.Settings_Value: model.value
    });
    return result;
  }

  Future<List<Map<String, dynamic>>> selectAllSettings() async {
    Database db = await DBScript.instance.database;
    var result = await db.rawQuery(
        'SELECT * FROM ${DBScript.DEVICE_SETTINGS} ORDER BY ${DBScript.Settings_ID}');
    return result;
  }

  Future<int> updateSettings(DeviceSettings model) async {
    Database db = await DBScript.instance.database;
    var result = await db.rawUpdate('''
    UPDATE ${DBScript.DEVICE_SETTINGS} 
    SET ${DBScript.Settings_Value} = ? WHERE ${DBScript.Settings_Key} = ?
    ''', [model.value, model.key]);
    return result;
  }

  Future<int?> checkKeyExists(String? keyName) async {
    Database db = await DBScript.instance.database;
    var result = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT(1) FROM ${DBScript.DEVICE_SETTINGS} WHERE ${DBScript.Settings_Key} = '$keyName'"));
    return result;
  }

  Future<int?> getSettingsCount() async {
    Database db = await DBScript.instance.database;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(1) FROM ${DBScript.DEVICE_SETTINGS}"));
    return result;
  }
}

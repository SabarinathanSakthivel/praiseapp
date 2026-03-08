import '../utils/db_utils/db_script.dart';

class DeviceSettings {
  int? id;
  String? key;
  String? value;
  DeviceSettings({this.id, this.key, this.value});
  Map<String, dynamic> toMap() {
    return {
      DBScript.Settings_ID: id,
      DBScript.Settings_Key: key,
      DBScript.Settings_Value: value
    };
  }

  DeviceSettings.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    key = map['Key'];
    value = map['Value'];
  }
}

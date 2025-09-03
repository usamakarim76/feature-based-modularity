import 'package:clean_architecture/core/constants/app_logs.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final AppLogger _appLogger = AppLogger(className: "Local Storage");

  // Store a string value
  Future<bool> setValue(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
    _appLogger.info("Successfully set value for key: $key with value: $value");
    return true;
  }

  // Read a string value
  Future<dynamic> readValue(String key) async {
    _appLogger.info("Reading value for key: $key");
    return await _secureStorage.read(key: key);
  }

  // Store a bool value
  Future<bool> setBoolValue(String key, bool value) async {
    await _secureStorage.write(key: key, value: value.toString());
    _appLogger.info(
      "Successfully set bool value for key: $key with value: $value",
    );
    return true;
  }

  // Read a bool value
  Future<bool?> readBoolValue(String key) async {
    _appLogger.info("Reading bool value for key: $key");
    String? value = await _secureStorage.read(key: key);
    return value == null ? null : value.toLowerCase() == 'true';
  }

  // Delete a value
  Future<bool> deleteValue(String key) async {
    await _secureStorage.delete(key: key);
    _appLogger.info("Successfully deleted value for key: $key");
    return true;
  }

  // Delete all data
  Future<bool> deleteAllData() async {
    await _secureStorage.deleteAll();
    _appLogger.info("Deleting all data from local storage");
    return true;
  }
}

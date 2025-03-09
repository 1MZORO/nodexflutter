import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
   final _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  /// Save Data
   Future<void> saveData(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
      print('::::: $value');
    } catch (e) {
      print("SecureStorage Error (saveData): $e");
    }
  }

  /// Read Data
   Future<String?> readData(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      print("SecureStorage Error (readData): $e");
      return null;
    }
  }

  /// Delete Data
   Future<void> deleteData(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      print("SecureStorage Error (deleteData): $e");
    }
  }

  /// Delete All Data
   Future<void> deleteAllData() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      print("SecureStorage Error (deleteAllData): $e");
    }
  }
}

import 'dart:convert';
import 'package:get/get.dart';
import 'package:maichoices/app/core/utils/keys.dart';
import 'package:maichoices/app/data/models/settings.dart';
import 'package:maichoices/app/data/services/storage/service.dart';

class SettingProvider {
  final StorageService _storage = Get.find<StorageService>();

  Settings readSettings() {
    final jsonData = jsonDecode(_storage.read(settingsKey).toString());
    if (jsonData == null) {
      return Settings(name: '', fullName: '');
    } else {
      return Settings.fromJson(jsonData);
    }
  }

  void writeSettings(Settings settings) {
    _storage.write(settingsKey, jsonEncode(settings.toJson()));
  }
}

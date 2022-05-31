import 'dart:convert';
import 'package:get/get.dart';
import 'package:maichoices/app/core/utils/keys.dart';
import 'package:maichoices/app/data/services/storage/service.dart';
import 'package:maichoices/app/data/models/user.dart';

class UserProvider {
  final StorageService _storage = Get.find<StorageService>();

  List<User> readUsers() {
    var users = <User>[];
    jsonDecode(_storage.read(userKey).toString()).forEach((e) => users.add(User.fromJson(e)));
    return users;
  }

  void writeUsers(List<User> users) {
    _storage.write(userKey, jsonEncode(users));
  }
}

import 'dart:convert';
import 'package:get/get.dart';
import 'package:mychoices/app/core/utils/keys.dart';
import 'package:mychoices/app/data/services/storage/service.dart';
import 'package:mychoices/app/data/models/user.dart';

class UserProvider {
  final StorageService _storage = Get.find<StorageService>();

  List<User> readUsers() {
    var users = <User>[];
    jsonDecode(_storage.read(userKey).toString())
        .forEach((e) => users.add(User.fromJson(e)));
    return users;
  }

  void writeUsers(List<User> users) {
    _storage.write(userKey, jsonEncode(users));
  }
}

import 'dart:convert';
import 'package:get/get.dart';
import 'package:maichoices/app/core/utils/keys.dart';
import 'package:maichoices/app/data/services/storage/service.dart';
import 'package:maichoices/app/data/models/choice.dart';

class TagProvider {
  final StorageService _storage = Get.find<StorageService>();

  List<Tag> readTags() {
    var tags = <Tag>[];
    jsonDecode(_storage.read(tagKey).toString()).forEach((e) => tags.add(Tag(name: e)));
    return tags;
  }

  void writeTags(List<Tag> tags) {
    final tagStrings = <String>[];
    for (Tag tag in tags) {
      tagStrings.add(tag.name);
    }
    _storage.write(tagKey, jsonEncode(tagStrings));
  }
}

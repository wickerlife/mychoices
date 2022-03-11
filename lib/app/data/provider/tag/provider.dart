import 'dart:convert';
import 'package:get/get.dart';
import 'package:mychoices/app/core/utils/keys.dart';
import 'package:mychoices/app/data/services/storage/service.dart';
import 'package:mychoices/app/data/models/choice.dart';

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

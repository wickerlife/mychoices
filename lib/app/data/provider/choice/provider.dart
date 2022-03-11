import 'dart:convert';
import 'package:get/get.dart';
import 'package:mychoices/app/core/utils/keys.dart';
import 'package:mychoices/app/data/services/storage/service.dart';
import 'package:mychoices/app/data/models/choice.dart';

class ChoiceProvider {
  final StorageService _storage = Get.find<StorageService>();

  List<Choice> readChoices() {
    var choices = <Choice>[];
    jsonDecode(_storage.read(choiceKey).toString()).forEach((e) => choices.add(Choice.fromJson(e)));
    return choices;
  }

  List<Choice> readTodaysChoices() {
    var todayChoices = <Choice>[];
    var today = DateTime.now();
    var year = today.year;
    var month = today.month;
    var day = today.day;
    readChoices().forEach(
      (e) {
        if (e.date.month == month && e.date.year == year && e.date.day == day) {
          todayChoices.add(e);
        }
      },
    );
    return todayChoices;
  }

  void writeChoices(List<Choice> choices) {
    _storage.write(choiceKey, jsonEncode(choices));
  }
}

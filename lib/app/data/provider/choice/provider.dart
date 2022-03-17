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
    choices.sort((a, b) => b.date.compareTo(a.date));
    return choices;
  }

  List<Choice> readDayChoices(DateTime date) {
    var todayChoices = <Choice>[];
    var year = date.year;
    var month = date.month;
    var day = date.day;
    readChoices().forEach(
      (e) {
        if (e.date.month == month && e.date.year == year && e.date.day == day) {
          todayChoices.add(e);
        }
      },
    );
    todayChoices.sort((b, a) => a.date.compareTo(b.date));
    return todayChoices;
  }

  void writeChoices(List<Choice> choices) {
    _storage.write(choiceKey, jsonEncode(choices.map((choice) => choice.toJson()).toList()));
  }

  void writeChoicesToDay(List<Choice> newChoices, DateTime date) {
    final allChoices = readChoices();
    final todayChoices = readDayChoices(date);

    for (var choice in allChoices) {
      if (todayChoices.contains(choice)) {
        allChoices.remove(choice);
      }
    }

    allChoices.addAll(newChoices);
    _storage.write(choiceKey, jsonEncode(allChoices.map((choice) => choice.toJson()).toList()));
  }
}

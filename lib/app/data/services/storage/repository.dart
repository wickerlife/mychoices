import 'package:flutter/cupertino.dart';
import 'package:mychoices/app/data/models/choice.dart';
import 'package:mychoices/app/data/provider/choice/provider.dart';
import 'package:mychoices/app/data/provider/tag/provider.dart';

class ChoiceRepository {
  ChoiceProvider choiceProvider;
  ChoiceRepository({required this.choiceProvider});

  List<Choice> readChoices() => choiceProvider.readChoices();

  List<Choice> readTodaysChoices() => choiceProvider.readTodaysChoices();

  void writeChoices(List<Choice> choices) => choiceProvider.writeChoices(choices);
}

class TagRepository {
  TagProvider tagProvider;
  TagRepository({required this.tagProvider});

  List<Tag> readTags() => tagProvider.readTags();

  void writeTags(List<Tag> tags) => tagProvider.writeTags(tags);
}

import 'package:maichoices/app/data/models/choice.dart';
import 'package:maichoices/app/data/models/settings.dart';
import 'package:maichoices/app/data/provider/choice/provider.dart';
import 'package:maichoices/app/data/provider/settings/provider.dart';
import 'package:maichoices/app/data/provider/tag/provider.dart';

class ChoiceRepository {
  ChoiceProvider choiceProvider;
  ChoiceRepository({required this.choiceProvider});

  List<Choice> readChoices() => choiceProvider.readChoices();

  List<Choice> readDayChoices(DateTime date) => choiceProvider.readDayChoices(date);

  void writeChoices(List<Choice> choices) => choiceProvider.writeChoices(choices);

  void writeChoicesToDay(List<Choice> newChoices, DateTime date) => choiceProvider.writeChoicesToDay(newChoices, date);
}

class TagRepository {
  TagProvider tagProvider;
  TagRepository({required this.tagProvider});

  List<Tag> readTags() => tagProvider.readTags();

  void writeTags(List<Tag> tags) => tagProvider.writeTags(tags);
}

class SettingRepository {
  SettingProvider settingProvider;
  SettingRepository({required this.settingProvider});

  Settings readSettings() => settingProvider.readSettings();
  void writeSettings(Settings settings) => settingProvider.writeSettings(settings);
}
